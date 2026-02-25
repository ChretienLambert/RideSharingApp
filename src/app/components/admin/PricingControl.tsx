import React, { useState } from 'react';
import { Card } from '../Card';
import { Button } from '../Button';
import { Input } from '../Input';
import { Header } from '../Header';
import { DollarSign, TrendingUp, MapPin, Edit2, Save } from 'lucide-react';

interface PricingControlProps {
  onBack: () => void;
}

export function PricingControl({ onBack }: PricingControlProps) {
  const [editingRoute, setEditingRoute] = useState<number | null>(null);

  const [routes, setRoutes] = useState([
    {
      id: 1,
      from: 'Yaoundé Centre',
      to: 'Douala Akwa',
      basePrice: 5000,
      distance: 250,
      popularity: 'high'
    },
    {
      id: 2,
      from: 'Douala Bonaberi',
      to: 'Bafoussam',
      basePrice: 3500,
      distance: 180,
      popularity: 'medium'
    },
    {
      id: 3,
      from: 'Yaoundé Mvan',
      to: 'Bafoussam Centre',
      basePrice: 4000,
      distance: 200,
      popularity: 'high'
    },
    {
      id: 4,
      from: 'Douala Akwa',
      to: 'Limbé',
      basePrice: 2500,
      distance: 75,
      popularity: 'low'
    }
  ]);

  const updateRoutePrice = (id: number, newPrice: number) => {
    setRoutes(routes.map(route =>
      route.id === id ? { ...route, basePrice: newPrice } : route
    ));
    setEditingRoute(null);
  };

  const getPopularityColor = (popularity: string) => {
    switch (popularity) {
      case 'high': return 'text-primary bg-primary/10';
      case 'medium': return 'text-accent bg-accent/10';
      default: return 'text-muted-foreground bg-muted';
    }
  };

  const getPopularityLabel = (popularity: string) => {
    switch (popularity) {
      case 'high': return 'Très demandé';
      case 'medium': return 'Moyen';
      default: return 'Faible';
    }
  };

  return (
    <div className="min-h-screen bg-background pb-24">
      <Header onBack={onBack} title="Contrôle des tarifs" />

      <div className="px-4 py-6 space-y-6">
        {/* Overview */}
        <Card className="bg-gradient-to-br from-accent/10 to-accent/5">
          <div className="flex items-center gap-3 mb-4">
            <div className="w-12 h-12 bg-accent rounded-2xl flex items-center justify-center">
              <DollarSign className="w-6 h-6 text-white" />
            </div>
            <div>
              <h3 className="font-bold">Tarification dynamique</h3>
              <p className="text-sm text-muted-foreground">Gérer les prix de base par route</p>
            </div>
          </div>
          
          <div className="grid grid-cols-2 gap-4 pt-4 border-t border-accent/20">
            <div>
              <p className="text-sm text-muted-foreground mb-1">Prix moyen</p>
              <p className="text-xl font-bold">
                {Math.round(routes.reduce((sum, r) => sum + r.basePrice, 0) / routes.length).toLocaleString()} FCFA
              </p>
            </div>
            <div>
              <p className="text-sm text-muted-foreground mb-1">Routes actives</p>
              <p className="text-xl font-bold">{routes.length}</p>
            </div>
          </div>
        </Card>

        {/* Pricing Strategy */}
        <Card>
          <h3 className="font-bold mb-3">Stratégie de tarification</h3>
          <div className="space-y-2 text-sm">
            <div className="flex items-center justify-between">
              <span className="text-muted-foreground">Commission plateforme</span>
              <span className="font-semibold">15%</span>
            </div>
            <div className="flex items-center justify-between">
              <span className="text-muted-foreground">Prix minimum par km</span>
              <span className="font-semibold">15 FCFA</span>
            </div>
            <div className="flex items-center justify-between">
              <span className="text-muted-foreground">Supplément haute demande</span>
              <span className="font-semibold">+20%</span>
            </div>
          </div>
        </Card>

        {/* Routes Pricing */}
        <div>
          <h3 className="font-bold mb-4">Tarifs par route</h3>
          
          <div className="space-y-3">
            {routes.map((route) => (
              <Card key={route.id}>
                <div className="space-y-4">
                  {/* Route Info */}
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <div className="space-y-2 mb-3">
                        <div className="flex items-center gap-2">
                          <MapPin className="w-4 h-4 text-primary flex-shrink-0" />
                          <span className="font-semibold text-sm">{route.from}</span>
                        </div>
                        <div className="flex items-center gap-2">
                          <MapPin className="w-4 h-4 text-destructive flex-shrink-0" />
                          <span className="font-semibold text-sm">{route.to}</span>
                        </div>
                      </div>
                      
                      <div className="flex items-center gap-2">
                        <span className={`px-2 py-1 rounded-lg text-xs font-semibold ${getPopularityColor(route.popularity)}`}>
                          {getPopularityLabel(route.popularity)}
                        </span>
                        <span className="text-xs text-muted-foreground">{route.distance} km</span>
                      </div>
                    </div>

                    <div className="text-right">
                      {editingRoute === route.id ? (
                        <Input
                          type="number"
                          defaultValue={route.basePrice}
                          className="w-24 text-right"
                          onBlur={(e) => updateRoutePrice(route.id, parseInt(e.target.value))}
                        />
                      ) : (
                        <>
                          <p className="text-sm text-muted-foreground">Prix de base</p>
                          <p className="text-2xl font-bold text-accent">{route.basePrice.toLocaleString()}</p>
                          <p className="text-xs text-muted-foreground">FCFA</p>
                        </>
                      )}
                    </div>
                  </div>

                  {/* Actions */}
                  <div className="flex gap-2 pt-2 border-t border-border">
                    {editingRoute === route.id ? (
                      <Button 
                        size="sm" 
                        fullWidth
                        onClick={() => setEditingRoute(null)}
                      >
                        <Save className="w-4 h-4 mr-2" />
                        Enregistrer
                      </Button>
                    ) : (
                      <Button 
                        variant="outline" 
                        size="sm" 
                        fullWidth
                        onClick={() => setEditingRoute(route.id)}
                      >
                        <Edit2 className="w-4 h-4 mr-2" />
                        Modifier le tarif
                      </Button>
                    )}
                  </div>
                </div>
              </Card>
            ))}
          </div>
        </div>

        {/* Add New Route */}
        <Button fullWidth size="lg" variant="outline">
          <MapPin className="w-5 h-5 mr-2" />
          Ajouter une nouvelle route
        </Button>
      </div>
    </div>
  );
}
