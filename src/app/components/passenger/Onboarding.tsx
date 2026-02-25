import React, { useState } from 'react';
import { Button } from '../Button';
import { Car, Users, Shield, ChevronRight } from 'lucide-react';

interface OnboardingProps {
  onComplete: () => void;
}

export function Onboarding({ onComplete }: OnboardingProps) {
  const [currentSlide, setCurrentSlide] = useState(0);

  const slides = [
    {
      icon: <Car className="w-20 h-20 text-primary" />,
      title: 'Voyagez en Toute Sécurité',
      description: 'Trouvez des trajets partagés vers votre destination à des prix abordables'
    },
    {
      icon: <Users className="w-20 h-20 text-primary" />,
      title: 'Communauté de Confiance',
      description: 'Partagez des trajets avec des conducteurs vérifiés et notés par la communauté'
    },
    {
      icon: <Shield className="w-20 h-20 text-primary" />,
      title: 'Paiement Sécurisé',
      description: 'Payez facilement avec Mobile Money (MTN, Orange) ou en espèces'
    }
  ];

  const handleNext = () => {
    if (currentSlide < slides.length - 1) {
      setCurrentSlide(currentSlide + 1);
    } else {
      onComplete();
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-primary/5 to-white flex flex-col">
      <div className="flex-1 flex flex-col items-center justify-center px-6 py-12">
        <div className="mb-8">
          {slides[currentSlide].icon}
        </div>
        
        <h2 className="text-2xl font-bold text-center mb-4">
          {slides[currentSlide].title}
        </h2>
        
        <p className="text-muted-foreground text-center mb-12 max-w-sm">
          {slides[currentSlide].description}
        </p>

        {/* Dots indicator */}
        <div className="flex gap-2 mb-12">
          {slides.map((_, index) => (
            <div
              key={index}
              className={`h-2 rounded-full transition-all ${
                index === currentSlide 
                  ? 'w-8 bg-primary' 
                  : 'w-2 bg-primary/20'
              }`}
            />
          ))}
        </div>
      </div>

      <div className="px-6 pb-8">
        <Button 
          onClick={handleNext} 
          fullWidth 
          size="lg"
        >
          {currentSlide === slides.length - 1 ? 'Commencer' : 'Suivant'}
          <ChevronRight className="w-5 h-5 ml-2" />
        </Button>
        
        {currentSlide < slides.length - 1 && (
          <button 
            onClick={onComplete}
            className="w-full mt-4 text-muted-foreground py-3"
          >
            Passer
          </button>
        )}
      </div>
    </div>
  );
}
