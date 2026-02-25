import React from 'react';
import { ArrowLeft, Menu } from 'lucide-react';

interface HeaderProps {
  title?: string;
  onBack?: () => void;
  onMenu?: () => void;
  rightAction?: React.ReactNode;
  transparent?: boolean;
}

export function Header({ title, onBack, onMenu, rightAction, transparent = false }: HeaderProps) {
  return (
    <header className={`sticky top-0 z-50 ${transparent ? 'bg-transparent' : 'bg-white border-b border-border'}`}>
      <div className="flex items-center justify-between px-4 py-4">
        <div className="flex items-center gap-3">
          {onBack && (
            <button 
              onClick={onBack}
              className="p-2 hover:bg-muted rounded-xl transition-colors"
            >
              <ArrowLeft className="w-6 h-6" />
            </button>
          )}
          {onMenu && (
            <button 
              onClick={onMenu}
              className="p-2 hover:bg-muted rounded-xl transition-colors"
            >
              <Menu className="w-6 h-6" />
            </button>
          )}
          {title && <h1 className="text-xl font-semibold">{title}</h1>}
        </div>
        
        {rightAction && (
          <div>{rightAction}</div>
        )}
      </div>
    </header>
  );
}
