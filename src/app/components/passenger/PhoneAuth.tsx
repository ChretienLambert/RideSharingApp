import React, { useState } from 'react';
import { Button } from '../Button';
import { Input } from '../Input';
import { Phone, Lock } from 'lucide-react';
import { Header } from '../Header';

interface PhoneAuthProps {
  onComplete: () => void;
  onBack: () => void;
}

export function PhoneAuth({ onComplete, onBack }: PhoneAuthProps) {
  const [step, setStep] = useState<'phone' | 'otp'>('phone');
  const [phoneNumber, setPhoneNumber] = useState('');
  const [otp, setOtp] = useState(['', '', '', '', '', '']);

  const handlePhoneSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setStep('otp');
  };

  const handleOtpChange = (index: number, value: string) => {
    if (value.length <= 1 && /^\d*$/.test(value)) {
      const newOtp = [...otp];
      newOtp[index] = value;
      setOtp(newOtp);
      
      // Auto-focus next input
      if (value && index < 5) {
        const nextInput = document.getElementById(`otp-${index + 1}`);
        nextInput?.focus();
      }
    }
  };

  const handleVerifyOtp = () => {
    if (otp.every(digit => digit !== '')) {
      onComplete();
    }
  };

  return (
    <div className="min-h-screen bg-white flex flex-col">
      <Header onBack={onBack} title="" />
      
      <div className="flex-1 px-6 py-8">
        <div className="mb-8">
          <h1 className="text-3xl font-bold mb-2">
            {step === 'phone' ? 'Connexion' : 'Vérification'}
          </h1>
          <p className="text-muted-foreground">
            {step === 'phone' 
              ? 'Entrez votre numéro de téléphone pour continuer' 
              : `Code envoyé au ${phoneNumber}`
            }
          </p>
        </div>

        {step === 'phone' ? (
          <form onSubmit={handlePhoneSubmit} className="space-y-6">
            <Input
              type="tel"
              label="Numéro de téléphone"
              placeholder="+237 6XX XXX XXX"
              value={phoneNumber}
              onChange={(e) => setPhoneNumber(e.target.value)}
              icon={<Phone className="w-5 h-5" />}
            />
            
            <Button type="submit" fullWidth size="lg">
              Continuer
            </Button>
          </form>
        ) : (
          <div className="space-y-6">
            <div>
              <label className="block mb-4 text-sm text-foreground">
                Code de vérification (6 chiffres)
              </label>
              <div className="flex gap-3 justify-center">
                {otp.map((digit, index) => (
                  <input
                    key={index}
                    id={`otp-${index}`}
                    type="text"
                    inputMode="numeric"
                    maxLength={1}
                    value={digit}
                    onChange={(e) => handleOtpChange(index, e.target.value)}
                    className="w-12 h-14 text-center text-xl font-semibold bg-input-background border-2 border-border rounded-xl focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all"
                  />
                ))}
              </div>
            </div>

            <Button onClick={handleVerifyOtp} fullWidth size="lg">
              Vérifier
            </Button>

            <button className="w-full text-primary text-center">
              Renvoyer le code
            </button>
          </div>
        )}
      </div>
    </div>
  );
}
