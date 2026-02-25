import React from 'react';

interface CardProps {
  children: React.ReactNode;
  className?: string;
  onClick?: () => void;
  hoverable?: boolean;
}

export function Card({ children, className = '', onClick, hoverable = false }: CardProps) {
  const hoverClass = hoverable || onClick ? 'hover:shadow-lg hover:scale-[1.02] cursor-pointer' : '';
  
  return (
    <div 
      className={`bg-card border border-border rounded-2xl p-4 transition-all duration-200 ${hoverClass} ${className}`}
      onClick={onClick}
    >
      {children}
    </div>
  );
}
