import React, { useState } from 'react';
import { Card } from '../Card';
import { Button } from '../Button';
import { Header } from '../Header';
import { MapPin, Users, Phone, MessageCircle, CheckCircle, X } from 'lucide-react';

interface RideRequestsProps {
  onBack: () => void;
}

export function RideRequests({ onBack }: RideRequestsProps) {
  const [requests, setRequests] = useState([
    {
      id: 1,
      passenger: 'Marie Dupont',
      rating: 4.9,
      from: 'Yaoundé Centre',
      to: 'Douala Akwa',
      seats: 2,
      price: '10,000 FCFA',
      status: 'pending'
    },
    {
      id: 2,
      passenger: 'Paul Nkolo',
      rating: 4.7,
      from: 'Yaoundé Mvan',
      to: 'Douala Akwa',
      seats: 1,
      price: '5,000 FCFA',
      status: 'pending'
    },
    {
      id: 3,
      passenger: 'Sophie Mbarga',
      rating: 5.0,
      from: 'Yaoundé Centre',
      to: 'Bafoussam',
      seats: 1,
      price: '4,000 FCFA',
      status: 'accepted'
    }
  ]);

  const handleAccept = (id: number) => {
    setRequests(requests.map(req =>
      req.id === id ? { ...req, status: 'accepted' } : req
    ));
  };

  const handleReject = (id: number) => {
    setRequests(requests.map(req =>
      req.id === id ? { ...req, status: 'rejected' } : req
    ));
  };

  const pendingRequests = requests.filter(r => r.status === 'pending');
  const acceptedRequests = requests.filter(r => r.status === 'accepted');

  return (
    <div className="min-h-screen bg-background pb-24">
      <Header onBack={onBack} title="Demandes de trajet" />

      <div className="px-4 py-6 space-y-6">
        {/* Pending Requests */}
        {pendingRequests.length > 0 && (
          <div>
            <h3 className="font-bold mb-4">
              Nouvelles demandes ({pendingRequests.length})
            </h3>
            
            <div className="space-y-3">
              {pendingRequests.map((request) => (
                <Card key={request.id} className="border-accent/20">
                  <div className="space-y-4">
                    {/* Passenger Info */}
                    <div className="flex items-center justify-between">
                      <div className="flex items-center gap-3">
                        <div className="w-12 h-12 bg-primary/10 rounded-2xl flex items-center justify-center">
                          <span className="text-primary font-semibold">
                            {request.passenger.split(' ').map(n => n[0]).join('')}
                          </span>
                        </div>
                        <div>
                          <h4 className="font-semibold">{request.passenger}</h4>
                          <div className="flex items-center gap-1 text-sm">
                            <span className="text-accent">★</span>
                            <span className="font-semibold">{request.rating}</span>
                            <span className="text-muted-foreground">(45 trajets)</span>
                          </div>
                        </div>
                      </div>
                      <div className="text-right">
                        <p className="font-bold text-accent">{request.price}</p>
                        <div className="flex items-center gap-1 text-sm text-muted-foreground">
                          <Users className="w-4 h-4" />
                          <span>{request.seats}</span>
                        </div>
                      </div>
                    </div>

                    {/* Route */}
                    <div className="space-y-2 text-sm">
                      <div className="flex items-center gap-2">
                        <MapPin className="w-4 h-4 text-primary flex-shrink-0" />
                        <span className="text-muted-foreground">{request.from}</span>
                      </div>
                      <div className="flex items-center gap-2">
                        <MapPin className="w-4 h-4 text-destructive flex-shrink-0" />
                        <span className="text-muted-foreground">{request.to}</span>
                      </div>
                    </div>

                    {/* Actions */}
                    <div className="flex gap-2">
                      <Button
                        onClick={() => handleReject(request.id)}
                        variant="outline"
                        className="flex-1"
                      >
                        <X className="w-4 h-4 mr-2" />
                        Refuser
                      </Button>
                      <Button
                        onClick={() => handleAccept(request.id)}
                        className="flex-1"
                      >
                        <CheckCircle className="w-4 h-4 mr-2" />
                        Accepter
                      </Button>
                    </div>
                  </div>
                </Card>
              ))}
            </div>
          </div>
        )}

        {/* Accepted Requests */}
        {acceptedRequests.length > 0 && (
          <div>
            <h3 className="font-bold mb-4">
              Passagers confirmés ({acceptedRequests.length})
            </h3>
            
            <div className="space-y-3">
              {acceptedRequests.map((request) => (
                <Card key={request.id} className="bg-primary/5 border-primary/20">
                  <div className="space-y-4">
                    {/* Passenger Info */}
                    <div className="flex items-center justify-between">
                      <div className="flex items-center gap-3">
                        <div className="w-12 h-12 bg-primary/10 rounded-2xl flex items-center justify-center">
                          <span className="text-primary font-semibold">
                            {request.passenger.split(' ').map(n => n[0]).join('')}
                          </span>
                        </div>
                        <div>
                          <h4 className="font-semibold">{request.passenger}</h4>
                          <div className="flex items-center gap-1">
                            <CheckCircle className="w-4 h-4 text-primary" />
                            <span className="text-sm text-primary font-semibold">Confirmé</span>
                          </div>
                        </div>
                      </div>
                      <div className="text-right">
                        <p className="font-bold text-accent">{request.price}</p>
                        <div className="flex items-center gap-1 text-sm text-muted-foreground">
                          <Users className="w-4 h-4" />
                          <span>{request.seats}</span>
                        </div>
                      </div>
                    </div>

                    {/* Route */}
                    <div className="space-y-2 text-sm">
                      <div className="flex items-center gap-2">
                        <MapPin className="w-4 h-4 text-primary flex-shrink-0" />
                        <span className="text-muted-foreground">{request.from}</span>
                      </div>
                      <div className="flex items-center gap-2">
                        <MapPin className="w-4 h-4 text-destructive flex-shrink-0" />
                        <span className="text-muted-foreground">{request.to}</span>
                      </div>
                    </div>

                    {/* Contact Actions */}
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
                  </div>
                </Card>
              ))}
            </div>
          </div>
        )}

        {/* Empty State */}
        {pendingRequests.length === 0 && acceptedRequests.length === 0 && (
          <Card className="text-center py-12">
            <Users className="w-16 h-16 text-muted-foreground mx-auto mb-4" />
            <h3 className="font-bold mb-2">Aucune demande</h3>
            <p className="text-muted-foreground text-sm">
              Les demandes de passagers apparaîtront ici
            </p>
          </Card>
        )}
      </div>
    </div>
  );
}
