import React, { useState } from 'react';
import { Card } from '../Card';
import { Button } from '../Button';
import { Header } from '../Header';
import { MapPin, Star, Calendar, MessageCircle } from 'lucide-react';

interface RideHistoryProps {
  onBack: () => void;
}

export function RideHistory({ onBack }: RideHistoryProps) {
  const [selectedRide, setSelectedRide] = useState<number | null>(null);

  const rides = [
    {
      id: 1,
      driver: 'Jean Kamga',
      from: 'Yaoundé Centre',
      to: 'Douala Akwa',
      date: '28 Jan 2026',
      price: '5,000 FCFA',
      rating: 4.8,
      status: 'completed',
      userRating: null
    },
    {
      id: 2,
      driver: 'Marie Ngo',
      from: 'Douala Bonaberi',
      to: 'Bafoussam',
      date: '15 Jan 2026',
      price: '3,500 FCFA',
      rating: 5.0,
      status: 'completed',
      userRating: 5
    },
    {
      id: 3,
      driver: 'Paul Tchouta',
      from: 'Yaoundé Mvan',
      to: 'Bafoussam Centre',
      date: '10 Jan 2026',
      price: '4,000 FCFA',
      rating: 4.6,
      status: 'completed',
      userRating: 4
    },
    {
      id: 4,
      driver: 'Sophie Mbarga',
      from: 'Douala Akwa',
      to: 'Limbé',
      date: '5 Jan 2026',
      price: '2,500 FCFA',
      rating: 4.9,
      status: 'cancelled',
      userRating: null
    }
  ];

  const RatingModal = ({ ride, onClose, onSubmit }: any) => {
    const [rating, setRating] = useState(0);
    const [comment, setComment] = useState('');

    return (
      <div className="fixed inset-0 bg-black/50 z-50 flex items-end sm:items-center justify-center p-4">
        <div className="bg-white rounded-t-3xl sm:rounded-3xl w-full max-w-lg p-6 space-y-6 animate-in slide-in-from-bottom-8 duration-300">
          <div className="text-center">
            <h3 className="text-xl font-bold mb-2">Noter ce trajet</h3>
            <p className="text-muted-foreground">Trajet avec {ride.driver}</p>
          </div>

          {/* Star Rating */}
          <div className="flex justify-center gap-2">
            {[1, 2, 3, 4, 5].map((star) => (
              <button
                key={star}
                onClick={() => setRating(star)}
                className="transition-transform hover:scale-110"
              >
                <Star
                  className={`w-10 h-10 ${
                    star <= rating
                      ? 'fill-accent text-accent'
                      : 'text-muted-foreground'
                  }`}
                />
              </button>
            ))}
          </div>

          {/* Comment */}
          <div>
            <label className="block mb-2 text-sm font-semibold">
              Commentaire (optionnel)
            </label>
            <textarea
              value={comment}
              onChange={(e) => setComment(e.target.value)}
              placeholder="Partagez votre expérience..."
              className="w-full px-4 py-3 bg-input-background border border-border rounded-xl focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all resize-none"
              rows={3}
            />
          </div>

          <div className="flex gap-3">
            <Button variant="outline" fullWidth onClick={onClose}>
              Annuler
            </Button>
            <Button
              fullWidth
              onClick={() => onSubmit(rating, comment)}
              disabled={rating === 0}
            >
              Soumettre
            </Button>
          </div>
        </div>
      </div>
    );
  };

  return (
    <div className="min-h-screen bg-background pb-24">
      <Header onBack={onBack} title="Historique des trajets" />

      <div className="px-4 py-6 space-y-4">
        {rides.map((ride) => (
          <Card
            key={ride.id}
            hoverable
            className={ride.status === 'cancelled' ? 'opacity-60' : ''}
          >
            <div className="space-y-3">
              {/* Header */}
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <div className="flex items-center gap-2 mb-1">
                    <h4 className="font-semibold">{ride.driver}</h4>
                    <div className="flex items-center gap-1">
                      <Star className="w-4 h-4 fill-accent text-accent" />
                      <span className="text-sm">{ride.rating}</span>
                    </div>
                  </div>
                  <div className="flex items-center gap-2 text-sm text-muted-foreground">
                    <Calendar className="w-4 h-4" />
                    <span>{ride.date}</span>
                  </div>
                </div>

                <div className="text-right">
                  <p className="font-bold text-accent">{ride.price}</p>
                  {ride.status === 'cancelled' && (
                    <span className="text-xs text-destructive">Annulé</span>
                  )}
                </div>
              </div>

              {/* Route */}
              <div className="space-y-2">
                <div className="flex items-center gap-2 text-sm">
                  <MapPin className="w-4 h-4 text-primary flex-shrink-0" />
                  <span className="text-muted-foreground">{ride.from}</span>
                </div>
                <div className="flex items-center gap-2 text-sm">
                  <MapPin className="w-4 h-4 text-destructive flex-shrink-0" />
                  <span className="text-muted-foreground">{ride.to}</span>
                </div>
              </div>

              {/* Actions */}
              {ride.status === 'completed' && (
                <div className="pt-2 border-t border-border">
                  {ride.userRating ? (
                    <div className="flex items-center justify-between">
                      <span className="text-sm text-muted-foreground">Votre note:</span>
                      <div className="flex items-center gap-1">
                        {[...Array(ride.userRating)].map((_, i) => (
                          <Star key={i} className="w-4 h-4 fill-accent text-accent" />
                        ))}
                      </div>
                    </div>
                  ) : (
                    <Button
                      variant="outline"
                      fullWidth
                      size="sm"
                      onClick={() => setSelectedRide(ride.id)}
                    >
                      <Star className="w-4 h-4 mr-2" />
                      Noter ce trajet
                    </Button>
                  )}
                </div>
              )}
            </div>
          </Card>
        ))}
      </div>

      {/* Rating Modal */}
      {selectedRide && (
        <RatingModal
          ride={rides.find(r => r.id === selectedRide)}
          onClose={() => setSelectedRide(null)}
          onSubmit={(rating: number, comment: string) => {
            console.log('Rating submitted:', rating, comment);
            setSelectedRide(null);
          }}
        />
      )}
    </div>
  );
}
