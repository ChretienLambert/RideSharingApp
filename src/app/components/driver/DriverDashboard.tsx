import React from 'react';
import { Card } from '../Card';
import { Button } from '../Button';
import { Header } from '../Header';
import { DollarSign, Navigation, Clock, Users, TrendingUp, Calendar, MapPin } from 'lucide-react';

interface DriverDashboardProps {
  onCreateRide: () => void;
  onCreateScheduledRide: () => void;
  onViewRideRequests: () => void;
}

export function DriverDashboard({ onCreateRide, onCreateScheduledRide, onViewRideRequests }: DriverDashboardProps) {
  const stats = {
    todayEarnings: 45000,
    weeklyEarnings: 125000,
    monthlyEarnings: 487000,
    totalRides: 234,
    rating: 4.8,
    activeRides: 2
  };

  const upcomingRides = [
    {
      id: 1,
      passenger: 'Marie Dupont',
      from: 'Yaoundé Centre',
      to: 'Douala Akwa',
      time: '14:30',
      seats: 2,
      price: '10,000 FCFA'
    },
    {
      id: 2,
      passenger: 'Paul Nkolo',
      from: 'Yaoundé Mvan',
      to: 'Bafoussam',
      time: '17:00',
      seats: 1,
      price: '4,000 FCFA'
    }
  ];

  return (
    <div className="min-h-screen bg-background pb-24">
      <Header
        title="Tableau de bord"
        rightAction={
          <button className="relative p-2 hover:bg-muted rounded-xl transition-colors">
            <div className="w-10 h-10 bg-[#10b981] rounded-full flex items-center justify-center">
              <span className="text-white font-semibold">JK</span>
            </div>
          </button>
        }
      />

      <div className="px-4 py-6 space-y-6">
        {/* Earnings Overview */}
        <Card className="bg-gradient-to-br from-[#10b981] to-[#059669] text-white">
          <div className="flex items-start justify-between mb-6">
            <div>
              <p className="text-white/80 mb-1">Gains aujourd'hui</p>
              <h2 className="text-3xl font-bold">{stats.todayEarnings.toLocaleString()} FCFA</h2>
            </div>
            <div className="w-12 h-12 bg-white/20 rounded-2xl flex items-center justify-center">
              <DollarSign className="w-6 h-6" />
            </div>
          </div>

          <div className="grid grid-cols-2 gap-4 pt-4 border-t border-white/20">
            <div>
              <p className="text-white/80 text-sm mb-1">Cette semaine</p>
              <p className="font-bold">{stats.weeklyEarnings.toLocaleString()} FCFA</p>
            </div>
            <div>
              <p className="text-white/80 text-sm mb-1">Ce mois</p>
              <p className="font-bold">{stats.monthlyEarnings.toLocaleString()} FCFA</p>
            </div>
          </div>
        </Card>

        {/* Quick Stats */}
        <div className="grid grid-cols-3 gap-3">
          <Card className="text-center">
            <div className="w-10 h-10 bg-primary/10 rounded-xl flex items-center justify-center mx-auto mb-2">
              <Navigation className="w-5 h-5 text-primary" />
            </div>
            <p className="text-2xl font-bold">{stats.totalRides}</p>
            <p className="text-xs text-muted-foreground">Trajets totaux</p>
          </Card>

          <Card className="text-center">
            <div className="w-10 h-10 bg-accent/10 rounded-xl flex items-center justify-center mx-auto mb-2">
              <TrendingUp className="w-5 h-5 text-accent" />
            </div>
            <p className="text-2xl font-bold">{stats.rating}</p>
            <p className="text-xs text-muted-foreground">Note moyenne</p>
          </Card>

          <Card className="text-center">
            <div className="w-10 h-10 bg-info/10 rounded-xl flex items-center justify-center mx-auto mb-2" style={{ backgroundColor: 'rgb(59 130 246 / 0.1)' }}>
              <Clock className="w-5 h-5" style={{ color: '#3b82f6' }} />
            </div>
            <p className="text-2xl font-bold">{stats.activeRides}</p>
            <p className="text-xs text-muted-foreground">Trajets actifs</p>
          </Card>
        </div>

        {/* Quick Actions */}
        <div className="space-y-3">
          <Button onClick={onCreateRide} fullWidth size="lg" className="bg-primary">
            <Navigation className="w-5 h-5 mr-2" />
            Créer un trajet instantané
          </Button>

          <Button onClick={onCreateScheduledRide} fullWidth size="lg" variant="outline">
            <Calendar className="w-5 h-5 mr-2" />
            Créer un trajet programmé
          </Button>
        </div>

        {/* Upcoming Rides */}
        <div>
          <div className="flex items-center justify-between mb-4">
            <h3 className="font-bold">Trajets à venir</h3>
            <button onClick={onViewRideRequests} className="text-primary text-sm">
              Voir tout
            </button>
          </div>

          {upcomingRides.length === 0 ? (
            <Card className="text-center py-8">
              <Navigation className="w-12 h-12 text-muted-foreground mx-auto mb-3" />
              <p className="text-muted-foreground">Aucun trajet à venir</p>
            </Card>
          ) : (
            <div className="space-y-3">
              {upcomingRides.map((ride) => (
                <Card key={ride.id} hoverable>
                  <div className="flex items-start justify-between mb-3">
                    <div className="flex-1">
                      <div className="flex items-center gap-2 mb-1">
                        <div className="w-8 h-8 bg-primary/10 rounded-full flex items-center justify-center">
                          <span className="text-primary text-sm font-semibold">
                            {ride.passenger.split(' ').map(n => n[0]).join('')}
                          </span>
                        </div>
                        <h4 className="font-semibold">{ride.passenger}</h4>
                      </div>
                      <div className="flex items-center gap-2 text-sm text-muted-foreground">
                        <Clock className="w-4 h-4" />
                        <span>{ride.time}</span>
                      </div>
                    </div>
                    <div className="text-right">
                      <p className="font-bold text-accent">{ride.price}</p>
                      <div className="flex items-center gap-1 text-sm text-muted-foreground">
                        <Users className="w-4 h-4" />
                        <span>{ride.seats}</span>
                      </div>
                    </div>
                  </div>

                  <div className="space-y-1 text-sm">
                    <div className="flex items-center gap-2">
                      <MapPin className="w-4 h-4 text-primary flex-shrink-0" />
                      <span className="text-muted-foreground truncate">{ride.from}</span>
                    </div>
                    <div className="flex items-center gap-2">
                      <MapPin className="w-4 h-4 text-destructive flex-shrink-0" />
                      <span className="text-muted-foreground truncate">{ride.to}</span>
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
