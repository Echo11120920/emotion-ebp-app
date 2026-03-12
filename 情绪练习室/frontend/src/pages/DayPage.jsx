import React, { useState, useEffect } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { BookOpen, PenLine, Headphones, CheckCircle2, Circle, ChevronLeft, Clock, FileText } from 'lucide-react';
import { marked } from 'marked';

function DayPage({ courseData, progress, markExerciseComplete, setCurrentDay }) {
  const { dayId } = useParams();
  const navigate = useNavigate();
  const dayNum = parseInt(dayId);
  const baseUrl = import.meta.env.BASE_URL || '/';
  
  const day = courseData.days.find(d => d.day === dayNum);
  const [activeExercise, setActiveExercise] = useState(null);
  const [writeAnswers, setWriteAnswers] = useState({});
  const [readContentText, setReadContentText] = useState('');
  const [isLoadingContent, setIsLoadingContent] = useState(false);
  const [loadedDays, setLoadedDays] = useState(new Set());

  useEffect(() => {
    setCurrentDay(dayNum);
    window.scrollTo(0, 0);
  }, [dayNum, setCurrentDay]);

  // 自动加载阅读内容
  useEffect(() => {
    const readExercise = day?.exercises?.find(ex => ex.type === '阅读');
    if (readExercise && !loadedDays.has(dayNum)) {
      loadReadContent(dayNum);
      setLoadedDays(prev => new Set([...prev, dayNum]));
    }
  }, [day, dayNum]);

  // 获取本地音频路径
  const getLocalAudioPath = (day, type) => {
    const dayStr = day.toString().padStart(2, '0');
    const typeStr = type === '阅读' ? 'read' : 'listen';
    return `${baseUrl}audio/day${dayStr}_${typeStr}.mp3`;
  };

  const getAudioSource = (exercise) => {
    if (exercise.audioUrl) return exercise.audioUrl;
    return getLocalAudioPath(dayNum, exercise.type);
  };

  // 加载阅读内容
  const loadReadContent = async (day) => {
    setIsLoadingContent(true);
    try {
      let contentFile = '';
      const dayData = courseData.days.find(d => d.day === day);
      if (day >= 1 && day <= 6) {
        contentFile = `day0${day}_read.md`;
      } else if (day >= 7 && day <= 21) {
        contentFile = 'day07_21_read.md';
      }
      
      if (contentFile) {
        const response = await fetch(`${baseUrl}content/${contentFile}`);
        if (response.ok) {
          const text = await response.text();
          setReadContentText(text);
        } else {
          setReadContentText('内容加载失败，请稍后重试');
        }
      } else {
        const readExercise = dayData?.exercises?.find(ex => ex.type === '阅读');
        if (readExercise) {
          const fallback = [
            `# ${readExercise.title}`,
            '',
            `**Day ${dayData.day} · ${dayData.theme}**`,
            `**时长：**${readExercise.duration || '未标注'}`,
            '',
            '> 当前天数暂未提供离线阅读全文，建议结合上方音频完成本节阅读练习。',
            '',
            `**练习提示：**${readExercise.description || '请结合当天主题进行阅读与反思。'}`
          ].join('\n');
          setReadContentText(fallback);
        } else {
          setReadContentText('暂无阅读内容');
        }
      }
    } catch (e) {
      console.error('Failed to load read content:', e);
      setReadContentText('内容加载失败，请稍后重试');
    }
    setIsLoadingContent(false);
  };

  if (!day) {
    return (
      <div className="card text-center py-12">
        <p className="text-gray-500">未找到该日课程</p>
        <Link to="/" className="btn-primary mt-4 inline-block">返回首页</Link>
      </div>
    );
  }

  const getExerciseIcon = (type) => {
    switch (type) {
      case '阅读': return <BookOpen size={24} />;
      case '书写': return <PenLine size={24} />;
      case '正念': return <Headphones size={24} />;
      default: return <Circle size={24} />;
    }
  };

  const getExerciseColor = (type) => {
    switch (type) {
      case '阅读': return 'bg-rose-300';
      case '书写': return 'bg-pink-300';
      case '正念': return 'bg-purple-300';
      default: return 'bg-gray-400';
    }
  };

  const handleComplete = (exerciseId) => {
    markExerciseComplete(dayNum, exerciseId);
  };

  const handleWriteChange = (questionIndex, value) => {
    setWriteAnswers(prev => ({
      ...prev,
      [questionIndex]: value
    }));
  };

  const isExerciseCompleted = (exerciseId) => {
    return progress[`day${dayNum}-${exerciseId}`]?.completed;
  };

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center space-x-4">
        <button 
          onClick={() => navigate('/')}
          className="p-2 hover:bg-rose-50 rounded-lg transition-colors"
        >
          <ChevronLeft size={24} />
        </button>
        <div>
          <p className="text-sm text-gray-500">Day {day.day}</p>
          <h1 className="text-xl font-bold text-gray-900">{day.theme}</h1>
        </div>
      </div>

      {/* Progress */}
      <div className="card">
        <div className="flex items-center justify-between mb-2">
          <span className="text-sm text-gray-500">今日进度</span>
          <span className="text-sm font-medium text-rose-500">
            {day.exercises.filter(ex => isExerciseCompleted(ex.id)).length}/{day.exercises.length}
          </span>
        </div>
        <div className="w-full bg-rose-100 rounded-full h-2">
          <div 
            className="bg-rose-300 h-2 rounded-full transition-all duration-300"
            style={{ 
              width: `${(day.exercises.filter(ex => isExerciseCompleted(ex.id)).length / day.exercises.length) * 100}%` 
            }}
          />
        </div>
      </div>



      {/* Exercises List */}
      <div className="space-y-4">
        {day.exercises.map((exercise, index) => {
          const completed = isExerciseCompleted(exercise.id);
          const isActive = activeExercise === exercise.id;
          const audioSrc = getAudioSource(exercise);
          
          return (
            <div 
              key={exercise.id}
              className={`card transition-all duration-200 ${
                completed ? 'bg-green-50/50 border-green-200' : ''
              } ${isActive ? 'ring-2 ring-rose-300' : ''}`}
            >
              {/* Exercise Header */}
              <div 
                className="flex items-start justify-between cursor-pointer"
                onClick={() => setActiveExercise(isActive ? null : exercise.id)}
              >
                <div className="flex items-start space-x-4">
                  <div className={`w-12 h-12 rounded-xl flex items-center justify-center text-white ${
                    getExerciseColor(exercise.type)
                  }`}>
                    {getExerciseIcon(exercise.type)}
                  </div>
                  <div>
                    <div className="flex items-center space-x-2">
                      <span className="text-xs font-medium text-gray-400">练习 {index + 1}</span>
                      <span className={`text-xs px-2 py-0.5 rounded-full ${
                        exercise.type === '阅读' ? 'bg-rose-100 text-rose-500' :
                        exercise.type === '书写' ? 'bg-pink-100 text-pink-500' :
                        'bg-purple-100 text-purple-500'
                      }`}>
                        {exercise.type}
                      </span>
                    </div>
                    <h3 className={`font-semibold mt-1 ${completed ? 'text-green-700 line-through' : 'text-gray-900'}`}>
                      {exercise.title}
                    </h3>
                    {exercise.duration && (
                      <div className="flex items-center space-x-1 text-sm text-gray-500 mt-1">
                        <Clock size={14} />
                        <span>{exercise.duration}</span>
                      </div>
                    )}
                  </div>
                </div>
                
                <div className="flex items-center space-x-2">
                  {completed ? (
                    <CheckCircle2 size={24} className="text-green-500" />
                  ) : (
                    <Circle size={24} className="text-gray-300" />
                  )}
                </div>
              </div>

              {/* Exercise Content */}
              {isActive && (
                <div className="mt-6 pt-6 border-t border-gray-100">
                  {/* Audio Player for 阅读/正念: 放在最上方 */}
                  {(exercise.type === '阅读' || exercise.type === '正念') && audioSrc && (
                    <div className="bg-rose-50 rounded-xl p-4 mb-6">
                      <p className="text-sm font-medium text-gray-900 mb-2">音频练习</p>
                      <p className="text-xs text-gray-500 mb-3">边听边读，体验更佳</p>
                      <audio
                        src={audioSrc}
                        controls
                        preload="metadata"
                        className="w-full"
                      />
                    </div>
                  )}

                  {/* Read Content for 阅读: 默认展示渲染后的内容 */}
                  {exercise.type === '阅读' && (
                    <div className="mb-6">
                      {isLoadingContent ? (
                        <div className="bg-gray-50 rounded-xl p-8 text-center">
                          <div className="inline-block animate-spin rounded-full h-6 w-6 border-2 border-rose-300 border-t-rose-500 mb-2"></div>
                          <p className="text-gray-500 text-sm">加载阅读内容...</p>
                        </div>
                      ) : readContentText ? (
                        <div className="bg-white rounded-xl p-6 border border-gray-100">
                          <div 
                            className="prose prose-rose max-w-none prose-headings:text-gray-900 prose-p:text-gray-700 prose-strong:text-gray-900 prose-blockquote:border-l-rose-300 prose-blockquote:bg-rose-50/50 prose-blockquote:py-2 prose-blockquote:px-4 prose-blockquote:rounded-r-lg prose-li:text-gray-700"
                            dangerouslySetInnerHTML={{ __html: marked.parse(readContentText) }}
                          />
                        </div>
                      ) : (
                        <div className="bg-gray-50 rounded-xl p-6 text-center">
                          <p className="text-gray-500 text-sm">暂无阅读内容</p>
                        </div>
                      )}
                    </div>
                  )}

                  {/* Writing Questions */}
                  {exercise.type === '书写' && exercise.questions && (
                    <div className="space-y-4 mb-6">
                      {exercise.questions.map((question, qIndex) => (
                        <div key={qIndex}>
                          <label className="block text-sm font-medium text-gray-700 mb-2">
                            {question}
                          </label>
                          <textarea
                            className="w-full p-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-rose-300 focus:border-transparent resize-none"
                            rows={4}
                            placeholder="写下你的想法..."
                            value={writeAnswers[qIndex] || ''}
                            onChange={(e) => handleWriteChange(qIndex, e.target.value)}
                          />
                        </div>
                      ))}
                    </div>
                  )}

                  {/* Complete Button */}
                  <button
                    onClick={() => handleComplete(exercise.id)}
                    className={`w-full py-3 rounded-xl font-medium transition-colors ${
                      completed 
                        ? 'bg-green-100 text-green-700 cursor-default' 
                        : 'btn-primary'
                    }`}
                    disabled={completed}
                  >
                    {completed ? '已完成 ✓' : '标记为已完成'}
                  </button>
                </div>
              )}
            </div>
          );
        })}
      </div>

      {/* Navigation */}
      <div className="flex items-center justify-between pt-4">
        {dayNum > 0 && (
          <Link 
            to={`/day/${dayNum - 1}`}
            className="btn-secondary flex items-center space-x-2"
          >
            <ChevronLeft size={18} />
            <span>前一天</span>
          </Link>
        )}
        
        {dayNum < courseData.course.totalDays && (
          <Link 
            to={`/day/${dayNum + 1}`}
            className="btn-primary flex items-center space-x-2 ml-auto"
          >
            <span>后一天</span>
            <ChevronLeft size={18} className="rotate-180" />
          </Link>
        )}
      </div>
    </div>
  );
}

export default DayPage;