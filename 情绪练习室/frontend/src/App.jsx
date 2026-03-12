import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import HomePage from './pages/HomePage';
import DayPage from './pages/DayPage';
import ProgressPage from './pages/ProgressPage';
import Navigation from './components/Navigation';
import courseData from './data/course-data.json';

function App() {
  const baseName = import.meta.env.BASE_URL || '/';

  const [progress, setProgress] = useState(() => {
    const saved = localStorage.getItem('emotion-ebp-progress');
    return saved ? JSON.parse(saved) : {};
  });

  const [currentDay, setCurrentDay] = useState(() => {
    const saved = localStorage.getItem('emotion-ebp-current-day');
    return saved ? parseInt(saved) : 1;
  });

  useEffect(() => {
    localStorage.setItem('emotion-ebp-progress', JSON.stringify(progress));
  }, [progress]);

  useEffect(() => {
    localStorage.setItem('emotion-ebp-current-day', currentDay.toString());
  }, [currentDay]);

  const markExerciseComplete = (dayId, exerciseId) => {
    setProgress(prev => ({
      ...prev,
      [`${dayId}-${exerciseId}`]: {
        completed: true,
        completedAt: new Date().toISOString()
      }
    }));
  };

  const getDayProgress = (dayId) => {
    const day = courseData.days.find(d => d.day === dayId);
    if (!day) return { completed: 0, total: 0 };
    
    const completed = day.exercises.filter(ex => 
      progress[`day${dayId}-${ex.id}`]?.completed
    ).length;
    
    return { completed, total: day.exercises.length };
  };

  const getOverallProgress = () => {
    let totalExercises = 0;
    let completedExercises = 0;
    
    courseData.days.forEach(day => {
      totalExercises += day.exercises.length;
      completedExercises += day.exercises.filter(ex => 
        progress[`day${day.day}-${ex.id}`]?.completed
      ).length;
    });
    
    return { completed: completedExercises, total: totalExercises };
  };

  return (
    <Router basename={baseName}>
      <div className="min-h-screen bg-gray-50">
        <Navigation currentDay={currentDay} overallProgress={getOverallProgress()} />
        <main className="container mx-auto px-4 py-6 max-w-4xl">
          <Routes>
            <Route 
              path="/" 
              element={
                <HomePage 
                  courseData={courseData}
                  progress={progress}
                  getDayProgress={getDayProgress}
                  currentDay={currentDay}
                  setCurrentDay={setCurrentDay}
                />
              } 
            />
            <Route 
              path="/day/:dayId" 
              element={
                <DayPage 
                  courseData={courseData}
                  progress={progress}
                  markExerciseComplete={markExerciseComplete}
                  setCurrentDay={setCurrentDay}
                />
              } 
            />
            <Route 
              path="/progress" 
              element={
                <ProgressPage 
                  courseData={courseData}
                  progress={progress}
                  getOverallProgress={getOverallProgress}
                />
              } 
            />
            <Route path="*" element={<Navigate to="/" replace />} />
          </Routes>
        </main>
      </div>
    </Router>
  );
}

export default App;