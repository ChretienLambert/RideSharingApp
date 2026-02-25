import React, { useState } from 'react';
import { Button } from '../Button';
import { Card } from '../Card';
import { Header } from '../Header';
import { Smartphone, Wallet, CheckCircle, CreditCard } from 'lucide-react';

interface PaymentProps {
  onBack: () => void;
  onPaymentComplete: () => void;
}

export function Payment({ onBack, onPaymentComplete }: PaymentProps) {
  const [paymentMethod, setPaymentMethod] = useState<'mtn' | 'orange' | 'cash' | null>(null);
  const [phoneNumber, setPhoneNumber] = useState('');

  const rideDetails = {
    from: 'Yaoundé Centre',
    to: 'Douala Akwa',
    price: 5000,
    seats: 1
  };

  const paymentMethods = [
    { id: 'mtn', name: 'MTN Mobile Money', icon: '📱', color: 'bg-yellow-500' },
    { id: 'orange', name: 'Orange Money', icon: '🍊', color: 'bg-orange-500' },
    { id: 'cash', name: 'Paiement en espèces', icon: '💵', color: 'bg-green-500' }
  ];

  const handlePayment = () => {
    // Simulate payment processing
    setTimeout(() => {
      onPaymentComplete();
    }, 1500);
  };

  return (
    <div className="min-h-screen bg-background pb-24">
      <Header onBack={onBack} title="Paiement" />

      <div className="px-4 py-6 space-y-6">
        {/* Ride Summary */}
        <Card className="bg-gradient-to-br from-primary/5 to-transparent">
          <h3 className="font-bold mb-4">Résumé du trajet</h3>
          
          <div className="space-y-3">
            <div className="flex justify-between">
              <span className="text-muted-foreground">Trajet</span>
              <span className="font-semibold">{rideDetails.from} → {rideDetails.to}</span>
            </div>
            <div className="flex justify-between">
              <span className="text-muted-foreground">Places</span>
              <span className="font-semibold">{rideDetails.seats} personne</span>
            </div>
            <div className="h-px bg-border my-2" />
            <div className="flex justify-between items-center">
              <span className="font-bold">Total</span>
              <span className="text-2xl font-bold text-accent">{rideDetails.price.toLocaleString()} FCFA</span>
            </div>
          </div>
        </Card>

        {/* Payment Methods */}
        <div>
          <h3 className="font-bold mb-4">Méthode de paiement</h3>
          
          <div className="space-y-3">
            {paymentMethods.map((method) => (
              <Card
                key={method.id}
                hoverable
                onClick={() => setPaymentMethod(method.id as any)}
                className={`cursor-pointer transition-all ${
                  paymentMethod === method.id 
                    ? 'ring-2 ring-primary bg-primary/5' 
                    : ''
                }`}
              >
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <div className={`w-12 h-12 ${method.color} rounded-xl flex items-center justify-center text-2xl`}>
                      {method.icon}
                    </div>
                    <div>
                      <p className="font-semibold">{method.name}</p>
                      {method.id !== 'cash' && (
                        <p className="text-xs text-muted-foreground">Instantané et sécurisé</p>
                      )}
                    </div>
                  </div>
                  {paymentMethod === method.id && (
                    <CheckCircle className="w-6 h-6 text-primary" />
                  )}
                </div>
              </Card>
            ))}
          </div>
        </div>

        {/* Mobile Money Input */}
        {paymentMethod && paymentMethod !== 'cash' && (
          <Card className="animate-in fade-in slide-in-from-bottom-4 duration-300">
            <label className="block mb-2 text-sm font-semibold">
              Numéro {paymentMethod === 'mtn' ? 'MTN' : 'Orange'} Money
            </label>
            <div className="relative">
              <Smartphone className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground" />
              <input
                type="tel"
                placeholder="+237 6XX XXX XXX"
                value={phoneNumber}
                onChange={(e) => setPhoneNumber(e.target.value)}
                className="w-full pl-10 pr-4 py-3 bg-input-background border border-border rounded-xl focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all"
              />
            </div>
            <p className="text-xs text-muted-foreground mt-2">
              Vous recevrez une notification pour confirmer le paiement
            </p>
          </Card>
        )}

        {/* Cash Payment Info */}
        {paymentMethod === 'cash' && (
          <Card className="bg-accent/10 border-accent/20 animate-in fade-in slide-in-from-bottom-4 duration-300">
            <div className="flex gap-3">
              <Wallet className="w-5 h-5 text-accent flex-shrink-0 mt-1" />
              <div>
                <p className="font-semibold mb-1">Paiement en espèces</p>
                <p className="text-sm text-muted-foreground">
                  Vous paierez {rideDetails.price.toLocaleString()} FCFA directement au conducteur à la fin du trajet.
                </p>
              </div>
            </div>
          </Card>
        )}

        {/* Security Badge */}
        <Card className="bg-muted/50">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 bg-primary/10 rounded-xl flex items-center justify-center">
              <CheckCircle className="w-5 h-5 text-primary" />
            </div>
            <div className="flex-1">
              <p className="text-sm font-semibold">Paiement sécurisé</p>
              <p className="text-xs text-muted-foreground">Vos informations sont protégées</p>
            </div>
          </div>
        </Card>

        <Button 
          onClick={handlePayment} 
          fullWidth 
          size="lg"
          disabled={!paymentMethod || (paymentMethod !== 'cash' && !phoneNumber)}
        >
          <CreditCard className="w-5 h-5 mr-2" />
          {paymentMethod === 'cash' ? 'Confirmer la réservation' : 'Payer maintenant'}
        </Button>
      </div>
    </div>
  );
}
