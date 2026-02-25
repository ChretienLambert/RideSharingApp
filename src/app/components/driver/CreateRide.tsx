import React, { useState } from 'react';
import { Button } from '../Button';
import { Input } from '../Input';
import { Card } from '../Card';
import { Header } from '../Header';
import { MapPin, Users, DollarSign, Calendar, Clock, Navigation } from 'lucide-react';

interface CreateRideProps {
  onBack: () => void;
  onPublishRide: () => void;
}

export function CreateRide({ onBack, onPublishRide }: CreateRideProps) {
  const [departure, setDeparture] = useState('');
  const [destination, setDestination] = useState('');
  const [departureTime, setDepartureTime] = useState('');
  const [date, setDate] = useState('');
  const [availableSeats, setAvailableSeats] = useState(3);
  const [pricePerSeat, setPricePerSeat] = useState('');

  const totalEarnings = availableSeats * (parseInt(pricePerSeat) || 0);

  return (
    <div className="min-h-screen bg-background pb-24">
      <Header onBack={onBack} title="Créer un trajet" />

      <div className="px-4 py-6 space-y-6">
        {/* Info Banner */}
        <Card className="bg-gradient-to-br from-primary/10 to-primary/5 border-primary/20">
          <div className="flex gap-3">
            <Navigation className="w-5 h-5 text-primary flex-shrink-0 mt-1" />
            <div>
              <h3 className="font-bold mb-1">Trajet instantané</h3>
              <p className="text-sm text-muted-foreground">
                Publiez votre trajet et commencez à accepter des passagers immédiatement
              </p>
            </div>
          </div>
        </Card>

        {/* Route Details */}
        <Card>
          <h3 className="font-bold mb-4">Itinéraire</h3>
          
          <div className="space-y-4">
            <Input
              label="Point de départ"
              placeholder="Ex: Yaoundé Centre"
              value={departure}
              onChange={(e) => setDeparture(e.target.value)}
              icon={<MapPin className="w-5 h-5 text-primary" />}
            />
            
            <Input
              label="Destination"
              placeholder="Ex: Douala Akwa"
              value={destination}
              onChange={(e) => setDestination(e.target.value)}
              icon={<MapPin className="w-5 h-5 text-destructive" />}
            />
          </div>
        </Card>

        {/* Time and Date */}
        <Card>
          <h3 className="font-bold mb-4">Horaire</h3>
          
          <div className="grid grid-cols-2 gap-4">
            <Input
              type="date"
              label="Date"
              value={date}
              onChange={(e) => setDate(e.target.value)}
              icon={<Calendar className="w-5 h-5" />}
            />
            
            <Input
              type="time"
              label="Heure de départ"
              value={departureTime}
              onChange={(e) => setDepartureTime(e.target.value)}
              icon={<Clock className="w-5 h-5" />}
            />
          </div>
        </Card>

        {/* Seats and Pricing */}
        <Card>
          <h3 className="font-bold mb-4">Places et tarification</h3>
          
          <div className="space-y-4">
            <div>
              <label className="block mb-2 text-sm">Places disponibles</label>
              <div className="flex items-center gap-2">
                <button
                  onClick={() => setAvailableSeats(Math.max(1, availableSeats - 1))}
                  className="w-12 h-12 bg-muted hover:bg-muted/80 rounded-xl transition-colors text-xl"
                >
                  -
                </button>
                <div className="flex-1 h-12 bg-input-background border border-border rounded-xl flex items-center justify-center">
                  <Users className="w-5 h-5 mr-2 text-muted-foreground" />
                  <span className="font-semibold text-xl">{availableSeats}</span>
                </div>
                <button
                  onClick={() => setAvailableSeats(Math.min(7, availableSeats + 1))}
                  className="w-12 h-12 bg-muted hover:bg-muted/80 rounded-xl transition-colors text-xl"
                >
                  +
                </button>
              </div>
            </div>

            <Input
              type="number"
              label="Prix par place (FCFA)"
              placeholder="5000"
              value={pricePerSeat}
              onChange={(e) => setPricePerSeat(e.target.value)}
              icon={<DollarSign className="w-5 h-5" />}
            />
          </div>
        </Card>

        {/* Earnings Preview */}
        <Card className="bg-gradient-to-br from-accent/10 to-accent/5 border-accent/20">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-muted-foreground mb-1">Gains potentiels</p>
              <p className="text-3xl font-bold text-accent">
                {totalEarnings.toLocaleString()} FCFA
              </p>
            </div>
            <div className="w-16 h-16 bg-accent/20 rounded-2xl flex items-center justify-center">
              <DollarSign className="w-8 h-8 text-accent" />
            </div>
          </div>
          <p className="text-sm text-muted-foreground mt-3">
            Si toutes les places sont réservées
          </p>
        </Card>

        {/* Publish Button */}
        <Button onClick={onPublishRide} fullWidth size="lg">
          <Navigation className="w-5 h-5 mr-2" />
          Publier le trajet
        </Button>
      </div>
    </div>
  );
}
