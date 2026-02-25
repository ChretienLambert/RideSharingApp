import React, { useState } from 'react';
import { Card } from '../Card';
import { Button } from '../Button';
import { Header } from '../Header';
import { Users, Car, DollarSign, AlertCircle, TrendingUp, Activity, Shield } from 'lucide-react';

interface AdminDashboardProps {
  onManageUsers: () => void;
  onMonitorRides: () => void;
  onManageComplaints: () => void;
  onPricingControl: () => void;
}

export function AdminDashboard({ 
  onManageUsers, 
  onMonitorRides, 
  onManageComplaints,
  onPricingControl 
}: AdminDashboardProps) {
  const stats = {
    totalUsers: 12543,
    activeDrivers: 856,
    activePassengers: 3421,
    todayRides: 234,
    weeklyRevenue: 8450000,
    monthlyRevenue: 34200000,
    pendingComplaints: 12,
    resolvedToday: 8
  };

  const recentActivity = [
    { id: 1, type: 'new_user', user: 'Jean Kamga', action: 'Inscription conducteur', time: '5 min' },
    { id: 2, type: 'complaint', user: 'Marie Dupont', action: 'Plainte soumise', time: '12 min' },
    { id: 3, type: 'ride', user: 'Paul Nkolo', action: 'Trajet complété', time: '25 min' },
    { id: 4, type: 'new_user', user: 'Sophie Mbarga', action: 'Inscription passager', time: '1h' }
  ];

  return (
    <div className="min-h-screen bg-background pb-24">
      <Header
        title="Administration"
        rightAction={
          <button className="relative p-2 hover:bg-muted rounded-xl transition-colors">
            <div className="w-10 h-10 rounded-full flex items-center justify-center" style={{ backgroundColor: '#8b5cf6' }}>
              <Shield className="w-5 h-5 text-white" />
            </div>
          </button>
        }
      />

      <div className="px-4 py-6 space-y-6">
        {/* Key Metrics */}
        <div className="grid grid-cols-2 gap-4">
          <Card className="bg-gradient-to-br from-primary/10 to-primary/5">
            <div className="flex items-start justify-between mb-2">
              <div className="w-10 h-10 bg-primary/20 rounded-xl flex items-center justify-center">
                <Users className="w-5 h-5 text-primary" />
              </div>
            </div>
            <p className="text-2xl font-bold mb-1">{stats.totalUsers.toLocaleString()}</p>
            <p className="text-sm text-muted-foreground">Utilisateurs totaux</p>
          </Card>

          <Card className="bg-gradient-to-br from-accent/10 to-accent/5">
            <div className="flex items-start justify-between mb-2">
              <div className="w-10 h-10 bg-accent/20 rounded-xl flex items-center justify-center">
                <Car className="w-5 h-5 text-accent" />
              </div>
            </div>
            <p className="text-2xl font-bold mb-1">{stats.todayRides}</p>
            <p className="text-sm text-muted-foreground">Trajets aujourd'hui</p>
          </Card>

          <Card className="bg-gradient-to-br from-[#10b981]/10 to-[#10b981]/5">
            <div className="flex items-start justify-between mb-2">
              <div className="w-10 h-10 bg-[#10b981]/20 rounded-xl flex items-center justify-center">
                <DollarSign className="w-5 h-5" style={{ color: '#10b981' }} />
              </div>
            </div>
            <p className="text-2xl font-bold mb-1">
              {(stats.monthlyRevenue / 1000000).toFixed(1)}M
            </p>
            <p className="text-sm text-muted-foreground">Revenus mensuels</p>
          </Card>

          <Card className="bg-gradient-to-br from-destructive/10 to-destructive/5">
            <div className="flex items-start justify-between mb-2">
              <div className="w-10 h-10 bg-destructive/20 rounded-xl flex items-center justify-center">
                <AlertCircle className="w-5 h-5 text-destructive" />
              </div>
            </div>
            <p className="text-2xl font-bold mb-1">{stats.pendingComplaints}</p>
            <p className="text-sm text-muted-foreground">Plaintes en attente</p>
          </Card>
        </div>

        {/* Quick Actions */}
        <div>
          <h3 className="font-bold mb-4">Actions rapides</h3>
          <div className="grid grid-cols-2 gap-3">
            <Button onClick={onManageUsers} variant="outline" className="h-auto py-4 flex-col gap-2">
              <Users className="w-6 h-6" />
              <span className="text-sm">Gestion utilisateurs</span>
            </Button>
            
            <Button onClick={onMonitorRides} variant="outline" className="h-auto py-4 flex-col gap-2">
              <Car className="w-6 h-6" />
              <span className="text-sm">Suivi trajets</span>
            </Button>
            
            <Button onClick={onManageComplaints} variant="outline" className="h-auto py-4 flex-col gap-2">
              <AlertCircle className="w-6 h-6" />
              <span className="text-sm">Plaintes</span>
            </Button>
            
            <Button onClick={onPricingControl} variant="outline" className="h-auto py-4 flex-col gap-2">
              <DollarSign className="w-6 h-6" />
              <span className="text-sm">Tarification</span>
            </Button>
          </div>
        </div>

        {/* Active Users Overview */}
        <Card>
          <h3 className="font-bold mb-4">Utilisateurs actifs</h3>
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 bg-primary/10 rounded-xl flex items-center justify-center">
                  <Car className="w-5 h-5 text-primary" />
                </div>
                <div>
                  <p className="font-semibold">{stats.activeDrivers}</p>
                  <p className="text-sm text-muted-foreground">Conducteurs actifs</p>
                </div>
              </div>
              <div className="flex items-center gap-1 text-sm text-primary">
                <TrendingUp className="w-4 h-4" />
                <span>+12%</span>
              </div>
            </div>

            <div className="h-px bg-border" />

            <div className="flex items-center justify-between">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 bg-accent/10 rounded-xl flex items-center justify-center">
                  <Users className="w-5 h-5 text-accent" />
                </div>
                <div>
                  <p className="font-semibold">{stats.activePassengers}</p>
                  <p className="text-sm text-muted-foreground">Passagers actifs</p>
                </div>
              </div>
              <div className="flex items-center gap-1 text-sm text-primary">
                <TrendingUp className="w-4 h-4" />
                <span>+8%</span>
              </div>
            </div>
          </div>
        </Card>

        {/* Recent Activity */}
        <div>
          <h3 className="font-bold mb-4">Activité récente</h3>
          <div className="space-y-2">
            {recentActivity.map((activity) => (
              <Card key={activity.id} hoverable>
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <div className={`w-10 h-10 rounded-xl flex items-center justify-center ${
                      activity.type === 'complaint' ? 'bg-destructive/10' :
                      activity.type === 'new_user' ? 'bg-primary/10' :
                      'bg-accent/10'
                    }`}>
                      {activity.type === 'complaint' && <AlertCircle className="w-5 h-5 text-destructive" />}
                      {activity.type === 'new_user' && <Users className="w-5 h-5 text-primary" />}
                      {activity.type === 'ride' && <Car className="w-5 h-5 text-accent" />}
                    </div>
                    <div>
                      <p className="font-semibold text-sm">{activity.user}</p>
                      <p className="text-xs text-muted-foreground">{activity.action}</p>
                    </div>
                  </div>
                  <span className="text-xs text-muted-foreground">{activity.time}</span>
                </div>
              </Card>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
