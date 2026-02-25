import React, { useState } from 'react';
import { Card } from '../Card';
import { Button } from '../Button';
import { Input } from '../Input';
import { Header } from '../Header';
import { Users, Search, Shield, Ban, CheckCircle, Star, Car } from 'lucide-react';

interface UserManagementProps {
  onBack: () => void;
}

export function UserManagement({ onBack }: UserManagementProps) {
  const [searchQuery, setSearchQuery] = useState('');
  const [filterRole, setFilterRole] = useState<'all' | 'passenger' | 'driver'>('all');

  const users = [
    {
      id: 1,
      name: 'Jean Kamga',
      phone: '+237 6XX XXX 001',
      role: 'driver',
      rating: 4.8,
      totalRides: 234,
      status: 'active',
      verified: true
    },
    {
      id: 2,
      name: 'Marie Dupont',
      phone: '+237 6XX XXX 002',
      role: 'passenger',
      rating: 4.9,
      totalRides: 45,
      status: 'active',
      verified: true
    },
    {
      id: 3,
      name: 'Paul Nkolo',
      phone: '+237 6XX XXX 003',
      role: 'driver',
      rating: 4.6,
      totalRides: 156,
      status: 'suspended',
      verified: true
    },
    {
      id: 4,
      name: 'Sophie Mbarga',
      phone: '+237 6XX XXX 004',
      role: 'passenger',
      rating: 5.0,
      totalRides: 12,
      status: 'active',
      verified: false
    }
  ];

  const filteredUsers = users.filter(user => {
    const matchesSearch = user.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
                          user.phone.includes(searchQuery);
    const matchesRole = filterRole === 'all' || user.role === filterRole;
    return matchesSearch && matchesRole;
  });

  return (
    <div className="min-h-screen bg-background pb-24">
      <Header onBack={onBack} title="Gestion des utilisateurs" />

      <div className="px-4 py-6 space-y-6">
        {/* Search and Filter */}
        <div className="space-y-3">
          <Input
            placeholder="Rechercher par nom ou téléphone..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            icon={<Search className="w-5 h-5" />}
          />

          <div className="flex gap-2">
            <button
              onClick={() => setFilterRole('all')}
              className={`px-4 py-2 rounded-xl transition-all ${
                filterRole === 'all'
                  ? 'bg-primary text-white'
                  : 'bg-muted text-muted-foreground'
              }`}
            >
              Tous
            </button>
            <button
              onClick={() => setFilterRole('passenger')}
              className={`px-4 py-2 rounded-xl transition-all ${
                filterRole === 'passenger'
                  ? 'bg-primary text-white'
                  : 'bg-muted text-muted-foreground'
              }`}
            >
              Passagers
            </button>
            <button
              onClick={() => setFilterRole('driver')}
              className={`px-4 py-2 rounded-xl transition-all ${
                filterRole === 'driver'
                  ? 'bg-primary text-white'
                  : 'bg-muted text-muted-foreground'
              }`}
            >
              Conducteurs
            </button>
          </div>
        </div>

        {/* Stats */}
        <div className="grid grid-cols-3 gap-3">
          <Card className="text-center">
            <p className="text-2xl font-bold">{users.length}</p>
            <p className="text-xs text-muted-foreground">Total</p>
          </Card>
          <Card className="text-center">
            <p className="text-2xl font-bold text-primary">
              {users.filter(u => u.status === 'active').length}
            </p>
            <p className="text-xs text-muted-foreground">Actifs</p>
          </Card>
          <Card className="text-center">
            <p className="text-2xl font-bold text-destructive">
              {users.filter(u => u.status === 'suspended').length}
            </p>
            <p className="text-xs text-muted-foreground">Suspendus</p>
          </Card>
        </div>

        {/* Users List */}
        <div>
          <h3 className="font-bold mb-4">
            Utilisateurs ({filteredUsers.length})
          </h3>
          
          <div className="space-y-3">
            {filteredUsers.map((user) => (
              <Card key={user.id} hoverable>
                <div className="space-y-3">
                  {/* User Header */}
                  <div className="flex items-start justify-between">
                    <div className="flex items-center gap-3">
                      <div className={`w-12 h-12 rounded-2xl flex items-center justify-center ${
                        user.role === 'driver' ? 'bg-primary/10' : 'bg-accent/10'
                      }`}>
                        {user.role === 'driver' ? (
                          <Car className="w-6 h-6 text-primary" />
                        ) : (
                          <Users className="w-6 h-6 text-accent" />
                        )}
                      </div>
                      <div>
                        <div className="flex items-center gap-2">
                          <h4 className="font-semibold">{user.name}</h4>
                          {user.verified && (
                            <CheckCircle className="w-4 h-4 text-primary" />
                          )}
                        </div>
                        <p className="text-sm text-muted-foreground">{user.phone}</p>
                      </div>
                    </div>

                    <div className={`px-2 py-1 rounded-lg text-xs font-semibold ${
                      user.status === 'active' 
                        ? 'bg-primary/10 text-primary' 
                        : 'bg-destructive/10 text-destructive'
                    }`}>
                      {user.status === 'active' ? 'Actif' : 'Suspendu'}
                    </div>
                  </div>

                  {/* Stats */}
                  <div className="flex items-center gap-4 text-sm">
                    <div className="flex items-center gap-1">
                      <Star className="w-4 h-4 fill-accent text-accent" />
                      <span className="font-semibold">{user.rating}</span>
                    </div>
                    <div className="text-muted-foreground">
                      {user.totalRides} trajets
                    </div>
                    <div className="px-2 py-1 bg-muted rounded-lg text-xs">
                      {user.role === 'driver' ? 'Conducteur' : 'Passager'}
                    </div>
                  </div>

                  {/* Actions */}
                  <div className="flex gap-2 pt-2 border-t border-border">
                    <Button variant="outline" size="sm" className="flex-1">
                      <Shield className="w-4 h-4 mr-2" />
                      Détails
                    </Button>
                    {user.status === 'active' ? (
                      <Button variant="outline" size="sm" className="flex-1 text-destructive">
                        <Ban className="w-4 h-4 mr-2" />
                        Suspendre
                      </Button>
                    ) : (
                      <Button size="sm" className="flex-1">
                        <CheckCircle className="w-4 h-4 mr-2" />
                        Activer
                      </Button>
                    )}
                  </div>
                </div>
              </Card>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
