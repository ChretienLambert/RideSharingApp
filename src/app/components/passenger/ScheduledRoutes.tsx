import React, { useState } from 'react';
import { Card } from '../Card';
import { Button } from '../Button';
import { Header } from '../Header';
import { Calendar, Clock, MapPin, Users, Star } from 'lucide-react';

interface ScheduledRoutesProps {
  onBack: () => void;
  onBookRoute: () => void;
}

export function ScheduledRoutes({ onBack, onBookRoute }: ScheduledRoutesProps) {
  const [selectedDay, setSelectedDay] = useState<string>('lundi');

  const days = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];

  const routes = [
    {
      id: 1,
      from: 'Yaoundé Centre',
      to: 'Douala Akwa',
      driver: 'Jean Kamga',
      rating: 4.8,
      times: ['06:00', '12:00', '18:00'],
      price: '5,000 FCFA',
      seatsAvailable: 3,
      days: ['lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi']
    },
    {
      id: 2,
      from: 'Douala Bonaberi',
      to: 'Bafoussam',
      driver: 'Marie Ngo',
      rating: 5.0,
      times: ['07:00', '14:00'],
      price: '3,500 FCFA',
      seatsAvailable: 2,
      days: ['lundi', 'mercredi', 'vendredi']
    },
    {
      id: 3,
      from: 'Yaoundé Mvan',
      to: 'Bafoussam Centre',
      driver: 'Paul Tchouta',
      rating: 4.6,
      times: ['08:00', '16:00'],
      price: '4,000 FCFA',
      seatsAvailable: 4,
      days: ['lundi', 'mardi', 'jeudi', 'samedi']
    }
  ];

  const filteredRoutes = routes.filter(route => 
    route.days.includes(selectedDay.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-background pb-24">
      <Header onBack={onBack} title="Trajets programmés" />

      <div className="px-4 py-6 space-y-6">
        {/* Info Banner */}
        <Card className="bg-gradient-to-br from-primary/10 to-primary/5 border-primary/20">
          <div className="flex gap-3">
            <Calendar className="w-5 h-5 text-primary flex-shrink-0 mt-1" />
            <div>
              <h3 className="font-bold mb-1">Trajets réguliers</h3>
              <p className="text-sm text-muted-foreground">
                Réservez à l'avance avec des prix fixes et des horaires garantis
              </p>
            </div>
          </div>
        </Card>

        {/* Day Selector */}
        <div>
          <h3 className="font-bold mb-3">Sélectionnez un jour</h3>
          <div className="flex gap-2 overflow-x-auto pb-2">
            {days.map((day) => (
              <button
                key={day}
                onClick={() => setSelectedDay(day)}
                className={`px-4 py-2 rounded-xl whitespace-nowrap transition-all ${
                  selectedDay.toLowerCase() === day.toLowerCase()
                    ? 'bg-primary text-white'
                    : 'bg-muted text-muted-foreground hover:bg-muted/80'
                }`}
              >
                {day}
              </button>
            ))}
          </div>
        </div>

        {/* Routes List */}
        <div>
          <h3 className="font-bold mb-3">
            Trajets disponibles ({filteredRoutes.length})
          </h3>
          
          {filteredRoutes.length === 0 ? (
            <Card className="text-center py-8">
              <Calendar className="w-12 h-12 text-muted-foreground mx-auto mb-3" />
              <p className="text-muted-foreground">Aucun trajet programmé ce jour</p>
            </Card>
          ) : (
            <div className="space-y-4">
              {filteredRoutes.map((route) => (
                <Card key={route.id} hoverable>
                  <div className="space-y-4">
                    {/* Route Header */}
                    <div className="flex items-start justify-between">
                      <div className="flex-1">
                        <div className="flex items-center gap-2 mb-2">
                          <h4 className="font-bold">{route.driver}</h4>
                          <div className="flex items-center gap-1">
                            <Star className="w-4 h-4 fill-accent text-accent" />
                            <span className="text-sm font-semibold">{route.rating}</span>
                          </div>
                        </div>
                        
                        <div className="space-y-2">
                          <div className="flex items-center gap-2 text-sm">
                            <MapPin className="w-4 h-4 text-primary flex-shrink-0" />
                            <span className="text-muted-foreground">{route.from}</span>
                          </div>
                          <div className="flex items-center gap-2 text-sm">
                            <MapPin className="w-4 h-4 text-destructive flex-shrink-0" />
                            <span className="text-muted-foreground">{route.to}</span>
                          </div>
                        </div>
                      </div>
                      
                      <div className="text-right">
                        <p className="text-2xl font-bold text-accent">{route.price}</p>
                        <p className="text-xs text-muted-foreground">par personne</p>
                      </div>
                    </div>

                    {/* Time Slots */}
                    <div>
                      <p className="text-sm text-muted-foreground mb-2">Horaires de départ:</p>
                      <div className="flex flex-wrap gap-2">
                        {route.times.map((time) => (
                          <div
                            key={time}
                            className="flex items-center gap-2 px-3 py-2 bg-muted rounded-lg"
                          >
                            <Clock className="w-4 h-4 text-primary" />
                            <span className="font-semibold text-sm">{time}</span>
                          </div>
                        ))}
                      </div>
                    </div>

                    {/* Seats and Book Button */}
                    <div className="flex items-center justify-between pt-2 border-t border-border">
                      <div className="flex items-center gap-2 text-sm">
                        <Users className="w-4 h-4 text-muted-foreground" />
                        <span className="text-muted-foreground">
                          {route.seatsAvailable} place{route.seatsAvailable > 1 ? 's' : ''} disponible{route.seatsAvailable > 1 ? 's' : ''}
                        </span>
                      </div>
                      
                      <Button onClick={onBookRoute} size="sm">
                        Réserver
                      </Button>
                    </div>
                  </div>
                </Card>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
