import React, { useState } from 'react';
import { Button } from '../Button';
import { Input } from '../Input';
import { Card } from '../Card';
import { Header } from '../Header';
import { MapPin, Navigation, Calendar, Users, DollarSign, Clock } from 'lucide-react';

interface RideBookingProps {
  onBack: () => void;
  onConfirmBooking: () => void;
}

export function RideBooking({ onBack, onConfirmBooking }: RideBookingProps) {
  const [pickup, setPickup] = useState('');
  const [destination, setDestination] = useState('');
  const [seats, setSeats] = useState(1);
  const [date, setDate] = useState('');
  
  const estimatedPrice = seats * 5000;

  const popularRoutes = [
    { from: 'Yaoundé', to: 'Douala', price: '5,000 FCFA' },
    { from: 'Douala', to: 'Bafoussam', price: '3,500 FCFA' },
    { from: 'Yaoundé', to: 'Bafoussam', price: '4,000 FCFA' }
  ];

  return (
    <div className="min-h-screen bg-background pb-24">
      <Header onBack={onBack} title="Réserver un trajet" />

      <div className="px-4 py-6 space-y-6">
        {/* Map */}
        <Card className="p-0 overflow-hidden">
          <div className="h-56 bg-gradient-to-br from-muted to-muted/50 relative flex items-center justify-center">
            <Navigation className="w-12 h-12 text-muted-foreground" />
            <div className="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGRlZnM+PHBhdHRlcm4gaWQ9ImdyaWQiIHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgcGF0dGVyblVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+PHBhdGggZD0iTSAwIDAgTCAwIDIwIE0gMCAwIEwgMjAgMCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSJyZ2JhKDAsMCwwLDAuMDUpIiBzdHJva2Utd2lkdGg9IjEiLz48L3BhdHRlcm4+PC9kZWZzPjxyZWN0IHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZpbGw9InVybCgjZ3JpZCkiLz48L3N2Zz4=')] opacity-50" />
          </div>
        </Card>

        {/* Booking Form */}
        <Card>
          <h3 className="font-bold mb-4">Détails du trajet</h3>
          
          <div className="space-y-4">
            <Input
              label="Point de départ"
              placeholder="Ex: Yaoundé Centre"
              value={pickup}
              onChange={(e) => setPickup(e.target.value)}
              icon={<MapPin className="w-5 h-5 text-primary" />}
            />
            
            <Input
              label="Destination"
              placeholder="Ex: Douala Akwa"
              value={destination}
              onChange={(e) => setDestination(e.target.value)}
              icon={<MapPin className="w-5 h-5 text-destructive" />}
            />
            
            <div className="grid grid-cols-2 gap-4">
              <Input
                type="date"
                label="Date"
                value={date}
                onChange={(e) => setDate(e.target.value)}
                icon={<Calendar className="w-5 h-5" />}
              />
              
              <div>
                <label className="block mb-2 text-sm">Places</label>
                <div className="flex items-center gap-2">
                  <button
                    onClick={() => setSeats(Math.max(1, seats - 1))}
                    className="w-10 h-12 bg-muted hover:bg-muted/80 rounded-xl transition-colors"
                  >
                    -
                  </button>
                  <div className="flex-1 h-12 bg-input-background border border-border rounded-xl flex items-center justify-center font-semibold">
                    {seats}
                  </div>
                  <button
                    onClick={() => setSeats(Math.min(4, seats + 1))}
                    className="w-10 h-12 bg-muted hover:bg-muted/80 rounded-xl transition-colors"
                  >
                    +
                  </button>
                </div>
              </div>
            </div>
          </div>
        </Card>

        {/* Price Estimation */}
        <Card className="bg-accent/10 border-accent/20">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 bg-accent rounded-xl flex items-center justify-center">
                <DollarSign className="w-6 h-6 text-white" />
              </div>
              <div>
                <p className="text-sm text-muted-foreground">Prix estimé</p>
                <p className="text-2xl font-bold text-accent">{estimatedPrice.toLocaleString()} FCFA</p>
              </div>
            </div>
          </div>
        </Card>

        {/* Popular Routes */}
        <div>
          <h3 className="font-bold mb-3">Routes populaires</h3>
          <div className="space-y-2">
            {popularRoutes.map((route, index) => (
              <Card 
                key={index} 
                hoverable
                onClick={() => {
                  setPickup(route.from);
                  setDestination(route.to);
                }}
                className="flex items-center justify-between"
              >
                <div className="flex items-center gap-3">
                  <Navigation className="w-5 h-5 text-primary" />
                  <div>
                    <p className="font-semibold text-sm">{route.from} → {route.to}</p>
                    <p className="text-xs text-muted-foreground">Départ quotidien</p>
                  </div>
                </div>
                <p className="font-bold text-accent">{route.price}</p>
              </Card>
            ))}
          </div>
        </div>

        <Button onClick={onConfirmBooking} fullWidth size="lg">
          <Clock className="w-5 h-5 mr-2" />
          Rechercher des trajets
        </Button>
      </div>
    </div>
  );
}
