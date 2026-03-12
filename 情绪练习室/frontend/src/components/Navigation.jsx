import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { Home, Calendar, TrendingUp } from 'lucide-react';

function Navigation({ currentDay, overallProgress }) {
  const location = useLocation();
  const progressPercent = overallProgress.total > 0 
    ? Math.round((overallProgress.completed / overallProgress.total) * 100) 
    : 0;

  return (
    <nav className="bg-white/80 backdrop-blur-md border-b border-rose-100 sticky top-0 z-50">
      <div className="container mx-auto px-4 max-w-4xl">
        <div className="flex items-center justify-between h-16">
          <Link to="/" className="flex items-center space-x-2">
            <div className="w-10 h-10 bg-gradient-to-br from-rose-300 to-pink-300 rounded-xl flex items-center justify-center shadow-sm">
              <span className="text-white font-bold text-lg">🌸</span>
            </div>
            <span className="font-bold text-xl text-rose-400">情绪练习室</span>
          </Link>

          <div className="flex items-center space-x-2">
            <Link
              to="/"
              className={`p-2.5 rounded-xl transition-all ${
                location.pathname === '/'
                  ? 'bg-rose-100 text-rose-500'
                  : 'text-gray-400 hover:bg-rose-50'
              }`}
            >
              <Home size={22} />
            </Link>
            <Link
              to="/progress"
              className={`p-2.5 rounded-xl transition-all ${
                location.pathname === '/progress'
                  ? 'bg-rose-100 text-rose-500'
                  : 'text-gray-400 hover:bg-rose-50'
              }`}
            >
              <TrendingUp size={22} />
            </Link>
          </div>
        </div>

        {/* Progress Bar */}
        <div className="pb-4">
          <div className="flex items-center justify-between text-sm text-gray-500 mb-2">
            <span className="font-medium">总进度</span>
            <span className="font-medium text-rose-400">{progressPercent}%</span>
          </div>
          <div className="w-full bg-rose-100 rounded-full h-2">
            <div
              className="bg-gradient-to-r from-rose-300 to-pink-300 h-2 rounded-full transition-all duration-300"
              style={{ width: `${progressPercent}%` }}
            />
          </div>
        </div>
      </div>
    </nav>
  );
}

export default Navigation;