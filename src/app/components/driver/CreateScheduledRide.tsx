import React, { useState } from 'react';
import { Button } from '../Button';
import { Input } from '../Input';
import { Card } from '../Card';
import { Header } from '../Header';
import { MapPin, Users, DollarSign, Calendar, Clock, Repeat } from 'lucide-react';

interface CreateScheduledRideProps {
  onBack: () => void;
  onCreateSchedule: () => void;
}

export function CreateScheduledRide({ onBack, onCreateSchedule }: CreateScheduledRideProps) {
  const [departure, setDeparture] = useState('');
  const [destination, setDestination] = useState('');
  const [departureTime, setDepartureTime] = useState('');
  const [availableSeats, setAvailableSeats] = useState(3);
  const [pricePerSeat, setPricePerSeat] = useState('');
  const [selectedDays, setSelectedDays] = useState<string[]>([]);

  const days = [
    { id: 'lun', label: 'Lun' },
    { id: 'mar', label: 'Mar' },
    { id: 'mer', label: 'Mer' },
    { id: 'jeu', label: 'Jeu' },
    { id: 'ven', label: 'Ven' },
    { id: 'sam', label: 'Sam' },
    { id: 'dim', label: 'Dim' }
  ];

  const toggleDay = (dayId: string) => {
    setSelectedDays(prev =>
      prev.includes(dayId)
        ? prev.filter(d => d !== dayId)
        : [...prev, dayId]
    );
  };

  const estimatedMonthlyEarnings = selectedDays.length * 4 * availableSeats * (parseInt(pricePerSeat) || 0);

  return (
    <div className="min-h-screen bg-background pb-24">
      <Header onBack={onBack} title="Trajet programmé" />

      <div className="px-4 py-6 space-y-6">
        {/* Info Banner */}
        <Card className="bg-gradient-to-br from-primary/10 to-primary/5 border-primary/20">
          <div className="flex gap-3">
            <Repeat className="w-5 h-5 text-primary flex-shrink-0 mt-1" />
            <div>
              <h3 className="font-bold mb-1">Trajet récurrent</h3>
              <p className="text-sm text-muted-foreground">
                Créez un trajet régulier avec prix fixe et horaires garantis
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

        {/* Schedule */}
        <Card>
          <h3 className="font-bold mb-4">Planification</h3>
          
          <div className="space-y-4">
            <div>
              <label className="block mb-3 text-sm">Jours de la semaine</label>
              <div className="flex flex-wrap gap-2">
                {days.map((day) => (
                  <button
                    key={day.id}
                    onClick={() => toggleDay(day.id)}
                    className={`px-4 py-2 rounded-xl transition-all ${
                      selectedDays.includes(day.id)
                        ? 'bg-primary text-white'
                        : 'bg-muted text-muted-foreground hover:bg-muted/80'
                    }`}
                  >
                    {day.label}
                  </button>
                ))}
              </div>
            </div>

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
              label="Prix fixe par place (FCFA)"
              placeholder="5000"
              value={pricePerSeat}
              onChange={(e) => setPricePerSeat(e.target.value)}
              icon={<DollarSign className="w-5 h-5" />}
            />
          </div>
        </Card>

        {/* Earnings Estimate */}
        <Card className="bg-gradient-to-br from-accent/10 to-accent/5 border-accent/20">
          <div className="space-y-3">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground mb-1">Gains estimés par mois</p>
                <p className="text-3xl font-bold text-accent">
                  {estimatedMonthlyEarnings.toLocaleString()} FCFA
                </p>
              </div>
              <div className="w-16 h-16 bg-accent/20 rounded-2xl flex items-center justify-center">
                <DollarSign className="w-8 h-8 text-accent" />
              </div>
            </div>
            <p className="text-sm text-muted-foreground">
              Basé sur {selectedDays.length} jour{selectedDays.length > 1 ? 's' : ''} par semaine • Toutes places réservées
            </p>
          </div>
        </Card>

        {/* Create Button */}
        <Button 
          onClick={onCreateSchedule} 
          fullWidth 
          size="lg"
          disabled={selectedDays.length === 0}
        >
          <Calendar className="w-5 h-5 mr-2" />
          Créer le trajet récurrent
        </Button>
      </div>
    </div>
  );
}
