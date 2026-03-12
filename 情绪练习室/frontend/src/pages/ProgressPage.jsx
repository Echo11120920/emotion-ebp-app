import React from 'react';
import { TrendingUp, Calendar, Award, Clock } from 'lucide-react';
import { format, parseISO, differenceInDays } from 'date-fns';
import { zhCN } from 'date-fns/locale';

function ProgressPage({ courseData, progress, getOverallProgress }) {
  const overall = getOverallProgress();
  const progressPercent = overall.total > 0 
    ? Math.round((overall.completed / overall.total) * 100) 
    : 0;

  // Calculate stats
  const completedDays = courseData.days.filter(day => {
    const dayExercises = day.exercises.length;
    const completedExercises = day.exercises.filter(ex => 
      progress[`day${day.day}-${ex.id}`]?.completed
    ).length;
    return dayExercises > 0 && completedExercises === dayExercises;
  }).length;

  const streak = calculateStreak(progress);

  function calculateStreak(progress) {
    let streak = 0;
    const today = new Date();
    
    for (let i = 0; i < 28; i++) {
      const date = new Date(today);
      date.setDate(date.getDate() - i);
      const dateStr = format(date, 'yyyy-MM-dd');
      
      const hasActivity = Object.values(progress).some(p => 
        p.completed && p.completedAt && p.completedAt.startsWith(dateStr)
      );
      
      if (hasActivity) {
        streak++;
      } else if (i > 0) {
        break;
      }
    }
    
    return streak;
  }

  const getLastActivity = () => {
    const dates = Object.values(progress)
      .filter(p => p.completed && p.completedAt)
      .map(p => parseISO(p.completedAt))
      .sort((a, b) => b - a);
    
    return dates.length > 0 ? dates[0] : null;
  };

  const lastActivity = getLastActivity();

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold text-gray-900">学习进度</h1>

      {/* Overall Progress Card */}
      <div className="card bg-gradient-to-br from-primary-500 to-primary-600 text-white">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold">总进度</h2>
          <span className="text-3xl font-bold">{progressPercent}%</span>
        </div>
        <div className="w-full bg-white/20 rounded-full h-3 mb-4">
          <div 
            className="bg-white h-3 rounded-full transition-all duration-300"
            style={{ width: `${progressPercent}%` }}
          />
        </div>
        <p className="text-primary-100">
          已完成 {overall.completed} / {overall.total} 个练习
        </p>
      </div>

      {/* Stats Grid */}
      <div className="grid grid-cols-2 gap-4">
        <div className="card text-center">
          <div className="w-12 h-12 bg-green-100 text-green-600 rounded-xl flex items-center justify-center mx-auto mb-3">
            <Calendar size={24} />
          </div>
          <p className="text-2xl font-bold text-gray-900">{completedDays}</p>
          <p className="text-sm text-gray-500">已完成天数</p>
        </div>

        <div className="card text-center">
          <div className="w-12 h-12 bg-orange-100 text-orange-600 rounded-xl flex items-center justify-center mx-auto mb-3">
            <Award size={24} />
          </div>
          <p className="text-2xl font-bold text-gray-900">{streak}</p>
          <p className="text-sm text-gray-500">连续打卡</p>
        </div>
      </div>

      {/* Last Activity */}
      {lastActivity && (
        <div className="card">
          <div className="flex items-center space-x-3">
            <div className="w-10 h-10 bg-blue-100 text-blue-600 rounded-lg flex items-center justify-center">
              <Clock size={20} />
            </div>
            <div>
              <p className="text-sm text-gray-500">最近活动</p>
              <p className="font-medium text-gray-900">
                {format(lastActivity, 'MM月dd日 HH:mm', { locale: zhCN })}
              </p>
            </div>
          </div>
        </div>
      )}

      {/* Daily Progress */}
      <div>
        <h2 className="text-lg font-semibold text-gray-900 mb-4">每日进度</h2>
        <div className="space-y-3">
          {courseData.days.map(day => {
            const dayExercises = day.exercises.length;
            const completedExercises = day.exercises.filter(ex => 
              progress[`day${day.day}-${ex.id}`]?.completed
            ).length;
            const dayProgress = dayExercises > 0 ? (completedExercises / dayExercises) * 100 : 0;
            const isCompleted = dayProgress === 100;
            
            return (
              <div key={day.day} className="card py-4">
                <div className="flex items-center justify-between mb-2">
                  <div className="flex items-center space-x-3">
                    <span className={`text-sm font-medium w-12 ${
                      isCompleted ? 'text-green-600' : 'text-gray-500'
                    }`}>
                      Day {day.day}
                    </span>
                    <span className={`text-sm ${isCompleted ? 'text-green-700' : 'text-gray-700'}`}>
                      {day.theme}
                    </span>
                  </div>
                  <span className={`text-sm font-medium ${
                    isCompleted ? 'text-green-600' : 'text-gray-500'
                  }`}>
                    {completedExercises}/{dayExercises}
                  </span>
                </div>
                <div className="w-full bg-gray-100 rounded-full h-2">
                  <div 
                    className={`h-2 rounded-full transition-all duration-300 ${
                      isCompleted ? 'bg-green-500' : 'bg-primary-500'
                    }`}
                    style={{ width: `${dayProgress}%` }}
                  />
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
}

export default ProgressPage;