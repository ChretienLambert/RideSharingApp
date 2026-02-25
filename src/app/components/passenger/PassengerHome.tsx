import React from 'react';
import { Card } from '../Card';
import { Button } from '../Button';
import { MapPin, Navigation, Clock, Star, Calendar } from 'lucide-react';
import { Header } from '../Header';

interface PassengerHomeProps {
  onBookRide: () => void;
  onViewScheduledRoutes: () => void;
  onViewHistory: () => void;
}

export function PassengerHome({ onBookRide, onViewScheduledRoutes, onViewHistory }: PassengerHomeProps) {
  const recentRides = [
    {
      id: 1,
      driver: 'Jean Kamga',
      from: 'Yaoundé Centre',
      to: 'Douala Akwa',
      date: '28 Jan 2026',
      price: '5,000 FCFA',
      rating: 4.8
    },
    {
      id: 2,
      driver: 'Marie Ngo',
      from: 'Douala Bonaberi',
      to: 'Bafoussam',
      date: '15 Jan 2026',
      price: '3,500 FCFA',
      rating: 5.0
    }
  ];

  return (
    <div className="min-h-screen bg-background pb-24">
      <Header 
        title="Co-Voiturage"
        rightAction={
          <button className="relative p-2 hover:bg-muted rounded-xl transition-colors">
            <div className="w-10 h-10 bg-primary/10 rounded-full flex items-center justify-center">
              <span className="text-primary font-semibold">JK</span>
            </div>
          </button>
        }
      />

      <div className="px-4 py-6 space-y-6">
        {/* Quick Actions */}
        <Card className="bg-gradient-to-br from-primary to-primary/80 text-white p-6">
          <h2 className="text-xl font-bold mb-2">Où allez-vous ?</h2>
          <p className="text-white/90 mb-6">Trouvez un trajet partagé maintenant</p>
          
          <Button 
            onClick={onBookRide}
            variant="secondary"
            fullWidth
            size="lg"
            className="bg-white text-primary hover:bg-white/90"
          >
            <Navigation className="w-5 h-5 mr-2" />
            Réserver un trajet
          </Button>
        </Card>

        {/* Map Preview */}
        <Card className="p-0 overflow-hidden">
          <div className="h-48 bg-gradient-to-br from-muted to-muted/50 relative flex items-center justify-center">
            <MapPin className="w-12 h-12 text-muted-foreground" />
            <div className="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGRlZnM+PHBhdHRlcm4gaWQ9ImdyaWQiIHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgcGF0dGVyblVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+PHBhdGggZD0iTSAwIDAgTCAwIDIwIE0gMCAwIEwgMjAgMCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSJyZ2JhKDAsMCwwLDAuMDUpIiBzdHJva2Utd2lkdGg9IjEiLz48L3BhdHRlcm4+PC9kZWZzPjxyZWN0IHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZpbGw9InVybCgjZ3JpZCkiLz48L3N2Zz4=')] opacity-50" />
          </div>
          <div className="p-4">
            <button 
              onClick={onViewScheduledRoutes}
              className="w-full flex items-center justify-between text-left hover:bg-muted p-3 rounded-xl transition-colors"
            >
              <div className="flex items-center gap-3">
                <Calendar className="w-5 h-5 text-primary" />
                <div>
                  <h3 className="font-semibold">Trajets programmés</h3>
                  <p className="text-sm text-muted-foreground">Prix fixes • Horaires réguliers</p>
                </div>
              </div>
              <Clock className="w-5 h-5 text-muted-foreground" />
            </button>
          </div>
        </Card>

        {/* Recent Rides */}
        <div>
          <div className="flex items-center justify-between mb-4">
            <h3 className="font-bold">Trajets récents</h3>
            <button 
              onClick={onViewHistory}
              className="text-primary text-sm"
            >
              Voir tout
            </button>
          </div>
          
          <div className="space-y-3">
            {recentRides.map(ride => (
              <Card key={ride.id} hoverable>
                <div className="flex items-start justify-between mb-3">
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-1">
                      <h4 className="font-semibold">{ride.driver}</h4>
                      <div className="flex items-center gap-1">
                        <Star className="w-4 h-4 fill-accent text-accent" />
                        <span className="text-sm">{ride.rating}</span>
                      </div>
                    </div>
                    <p className="text-sm text-muted-foreground">{ride.date}</p>
                  </div>
                  <div className="text-right">
                    <p className="font-bold text-accent">{ride.price}</p>
                  </div>
                </div>
                
                <div className="flex items-center gap-2 text-sm">
                  <MapPin className="w-4 h-4 text-primary flex-shrink-0" />
                  <span className="text-muted-foreground truncate">{ride.from}</span>
                  <span className="text-muted-foreground">→</span>
                  <span className="text-muted-foreground truncate">{ride.to}</span>
                </div>
              </Card>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
