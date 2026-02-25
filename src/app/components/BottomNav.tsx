import React from 'react';

interface NavItem {
  icon: React.ReactNode;
  label: string;
  active: boolean;
  onClick: () => void;
}

interface BottomNavProps {
  items: NavItem[];
}

export function BottomNav({ items }: BottomNavProps) {
  return (
    <nav className="fixed bottom-0 left-0 right-0 bg-white border-t border-border safe-area-bottom">
      <div className="flex items-center justify-around px-2 py-3">
        {items.map((item, index) => (
          <button
            key={index}
            onClick={item.onClick}
            className={`flex flex-col items-center gap-1 px-4 py-2 rounded-xl transition-all ${
              item.active 
                ? 'text-primary bg-primary/10' 
                : 'text-muted-foreground hover:text-foreground hover:bg-muted'
            }`}
          >
            <div className="w-6 h-6">
              {item.icon}
            </div>
            <span className="text-xs">{item.label}</span>
          </button>
        ))}
      </div>
    </nav>
  );
}
