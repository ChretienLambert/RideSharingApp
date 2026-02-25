import React, { useState, useEffect } from 'react';
import { Card } from '../Card';
import { Button } from '../Button';
import { Header } from '../Header';
import { MapPin, Navigation, Phone, MessageCircle, Star, Clock, User } from 'lucide-react';

interface RideTrackingProps {
  onBack: () => void;
  onCompleteRide: () => void;
}

export function RideTracking({ onBack, onCompleteRide }: RideTrackingProps) {
  const [eta, setEta] = useState(15);

  useEffect(() => {
    const interval = setInterval(() => {
      setEta(prev => Math.max(0, prev - 1));
    }, 60000); // Update every minute
    return () => clearInterval(interval);
  }, []);

  const driver = {
    name: 'Jean Kamga',
    rating: 4.8,
    phone: '+237 6XX XXX XXX',
    car: 'Toyota Corolla',
    plate: 'YDE-1234-AB',
    photo: 'JK'
  };

  return (
    <div className="min-h-screen bg-background flex flex-col">
      <Header onBack={onBack} title="Suivi du trajet" />

      {/* Map */}
      <div className="flex-1 relative">
        <div className="absolute inset-0 bg-gradient-to-br from-primary/10 to-muted/50 flex items-center justify-center">
          <Navigation className="w-16 h-16 text-primary animate-pulse" />
          <div className="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGRlZnM+PHBhdHRlcm4gaWQ9ImdyaWQiIHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgcGF0dGVyblVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+PHBhdGggZD0iTSAwIDAgTCAwIDIwIE0gMCAwIEwgMjAgMCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSJyZ2JhKDAsMCwwLDAuMDUpIiBzdHJva2Utd2lkdGg9IjEiLz48L3BhdHRlcm4+PC9kZWZzPjxyZWN0IHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZpbGw9InVybCgjZ3JpZCkiLz48L3N2Zz4=')] opacity-30" />
        </div>

        {/* ETA Badge */}
        <div className="absolute top-4 left-1/2 -translate-x-1/2 z-10">
          <Card className="bg-white shadow-lg">
            <div className="flex items-center gap-2">
              <Clock className="w-5 h-5 text-primary" />
              <div>
                <p className="text-xs text-muted-foreground">Arrivée dans</p>
                <p className="font-bold text-primary">{eta} min</p>
              </div>
            </div>
          </Card>
        </div>
      </div>

      {/* Bottom Sheet */}
      <div className="bg-white rounded-t-3xl shadow-2xl p-6 space-y-4">
        {/* Driver Info */}
        <Card className="bg-gradient-to-br from-primary/5 to-transparent">
          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center gap-3">
              <div className="w-14 h-14 bg-primary rounded-2xl flex items-center justify-center">
                <span className="text-white font-bold text-lg">{driver.photo}</span>
              </div>
              <div>
                <h3 className="font-bold">{driver.name}</h3>
                <div className="flex items-center gap-1">
                  <Star className="w-4 h-4 fill-accent text-accent" />
                  <span className="text-sm font-semibold">{driver.rating}</span>
                  <span className="text-sm text-muted-foreground">(124 trajets)</span>
                </div>
              </div>
            </div>
            
            <div className="text-right">
              <p className="text-sm text-muted-foreground">{driver.car}</p>
              <p className="font-semibold text-sm">{driver.plate}</p>
            </div>
          </div>

          <div className="flex gap-2">
            <Button variant="outline" className="flex-1" size="sm">
              <Phone className="w-4 h-4 mr-2" />
              Appeler
            </Button>
            <Button variant="outline" className="flex-1" size="sm">
              <MessageCircle className="w-4 h-4 mr-2" />
              Message
            </Button>
          </div>
        </Card>

        {/* Route Info */}
        <div className="space-y-3">
          <div className="flex items-start gap-3">
            <div className="w-8 h-8 bg-primary/10 rounded-full flex items-center justify-center flex-shrink-0">
              <MapPin className="w-4 h-4 text-primary" />
            </div>
            <div className="flex-1">
              <p className="text-xs text-muted-foreground">Départ</p>
              <p className="font-semibold">Yaoundé Centre, Place Kennedy</p>
            </div>
          </div>

          <div className="ml-4 h-8 w-0.5 bg-border" />

          <div className="flex items-start gap-3">
            <div className="w-8 h-8 bg-destructive/10 rounded-full flex items-center justify-center flex-shrink-0">
              <MapPin className="w-4 h-4 text-destructive" />
            </div>
            <div className="flex-1">
              <p className="text-xs text-muted-foreground">Arrivée</p>
              <p className="font-semibold">Douala Akwa, Rue Joffre</p>
            </div>
          </div>
        </div>

        {/* Actions */}
        <div className="pt-2">
          <Button onClick={onCompleteRide} fullWidth size="lg" variant="outline">
            Annuler le trajet
          </Button>
        </div>
      </div>
    </div>
  );
}
