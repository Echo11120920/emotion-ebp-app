import React from 'react';
import { Link } from 'react-router-dom';
import { BookOpen, PenLine, Headphones, CheckCircle2, Circle, ChevronRight } from 'lucide-react';

function HomePage({ courseData, progress, getDayProgress, currentDay, setCurrentDay }) {
  const getExerciseIcon = (type) => {
    switch (type) {
      case '阅读': return <BookOpen size={18} />;
      case '书写': return <PenLine size={18} />;
      case '正念': return <Headphones size={18} />;
      default: return <Circle size={18} />;
    }
  };

  const getExerciseColor = (type) => {
    switch (type) {
      case '阅读': return 'bg-rose-100 text-rose-500 border-rose-200';
      case '书写': return 'bg-pink-100 text-pink-500 border-pink-200';
      case '正念': return 'bg-purple-100 text-purple-500 border-purple-200';
      default: return 'bg-gray-100 text-gray-500 border-gray-200';
    }
  };

  return (
    <div className="space-y-6">
      {/* Hero Section */}
      <div className="card bg-gradient-to-br from-rose-200 via-pink-200 to-purple-200 text-gray-700 shadow-sm">
        <div className="flex items-center space-x-3 mb-3">
          <span className="text-4xl">🌸</span>
          <h1 className="text-2xl font-bold text-gray-700">{courseData.course.name}</h1>
        </div>
        <p className="text-gray-600 mb-4 text-lg">{courseData.course.description}</p>
        <div className="flex items-center space-x-3 text-sm">
          <span className="bg-white/50 backdrop-blur-sm px-4 py-1.5 rounded-full font-medium text-gray-600">
            🗓 共 {courseData.course.totalDays} 天
          </span>
          <span className="bg-white/50 backdrop-blur-sm px-4 py-1.5 rounded-full font-medium text-gray-600">
            📍 当前第 {currentDay} 天
          </span>
        </div>
      </div>

      {/* Current Day Card */}
      {currentDay <= courseData.course.totalDays && (
        <div className="card border-rose-200 bg-gradient-to-br from-rose-50 to-pink-50">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">今日练习</h2>
            <span className="text-sm font-medium text-rose-500 bg-rose-100 px-3 py-1 rounded-full">
              Day {currentDay}
            </span>
          </div>
          {(() => {
            const today = courseData.days.find(d => d.day === currentDay);
            if (!today) return null;
            const dayProgress = getDayProgress(currentDay);
            
            return (
              <div>
                <h3 className="font-medium text-gray-900 mb-2">{today.theme}</h3>
                <p className="text-sm text-gray-500 mb-4">{today.title}</p>
                
                <div className="space-y-2 mb-4">
                  {today.exercises.map(exercise => {
                    const isCompleted = progress[`day${currentDay}-${exercise.id}`]?.completed;
                    return (
                      <div 
                        key={exercise.id}
                        className={`flex items-center space-x-3 p-3 rounded-lg border ${
                          isCompleted 
                            ? 'bg-green-50 border-green-200' 
                            : 'bg-white border-gray-100'
                        }`}
                      >
                        {isCompleted ? (
                          <CheckCircle2 size={18} className="text-green-500" />
                        ) : (
                          <div className={`w-5 h-5 rounded-full flex items-center justify-center text-xs ${getExerciseColor(exercise.type)}`}>
                            {getExerciseIcon(exercise.type)}
                          </div>
                        )}
                        <span className={`text-sm ${isCompleted ? 'text-green-700 line-through' : 'text-gray-700'}`}>
                          {exercise.title}
                        </span>
                      </div>
                    );
                  })}
                </div>
                
                <Link 
                  to={`/day/${currentDay}`}
                  className="btn-primary w-full flex items-center justify-center space-x-2"
                >
                  <span>开始练习</span>
                  <ChevronRight size={18} />
                </Link>
              </div>
            );
          })()}
        </div>
      )}

      {/* All Days List */}
      <div>
        <h2 className="text-lg font-semibold text-gray-900 mb-4">全部课程</h2>
        <div className="grid gap-3">
          {courseData.days.map(day => {
            const dayProgress = getDayProgress(day.day);
            const isActive = day.day === currentDay;
            const isCompleted = dayProgress.completed === dayProgress.total && dayProgress.total > 0;
            
            return (
              <Link 
                key={day.day}
                to={`/day/${day.day}`}
                className={`day-card flex items-center justify-between ${
                  isActive ? 'border-primary-300 bg-primary-50/30' : ''
                }`}
                onClick={() => setCurrentDay(day.day)}
              >
                <div className="flex items-center space-x-4">
                  <div className={`w-12 h-12 rounded-xl flex items-center justify-center font-bold text-sm ${
                    isCompleted 
                      ? 'bg-green-100 text-green-600' 
                      : isActive 
                        ? 'bg-primary-100 text-primary-600'
                        : 'bg-gray-100 text-gray-500'
                  }`}>
                    {isCompleted ? (
                      <CheckCircle2 size={20} />
                    ) : (
                      day.day
                    )}
                  </div>
                  <div>
                    <h3 className="font-medium text-gray-900">{day.theme}</h3>
                    <p className="text-sm text-gray-500">{day.exercises.length} 个练习</p>
                  </div>
                </div>
                
                <div className="flex items-center space-x-3">
                  {dayProgress.total > 0 && (
                    <span className={`text-xs px-2 py-1 rounded-full ${
                      dayProgress.completed === dayProgress.total
                        ? 'bg-green-100 text-green-600'
                        : 'bg-gray-100 text-gray-500'
                    }`}>
                      {dayProgress.completed}/{dayProgress.total}
                    </span>
                  )}
                  <ChevronRight size={18} className="text-gray-300" />
                </div>
              </Link>
            );
          })}
        </div>
      </div>
    </div>
  );
}

export default HomePage;