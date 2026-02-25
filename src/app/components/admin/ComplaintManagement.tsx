import React, { useState } from 'react';
import { Card } from '../Card';
import { Button } from '../Button';
import { Header } from '../Header';
import { AlertCircle, MessageCircle, CheckCircle, Clock, X } from 'lucide-react';

interface ComplaintManagementProps {
  onBack: () => void;
}

export function ComplaintManagement({ onBack }: ComplaintManagementProps) {
  const [selectedStatus, setSelectedStatus] = useState<'pending' | 'resolved' | 'all'>('pending');

  const complaints = [
    {
      id: 1,
      complainant: 'Marie Dupont',
      against: 'Jean Kamga (Conducteur)',
      type: 'Retard important',
      description: 'Le conducteur est arrivé 45 minutes en retard sans prévenir.',
      date: '4 Fév 2026',
      status: 'pending',
      severity: 'medium'
    },
    {
      id: 2,
      complainant: 'Paul Nkolo',
      against: 'Sophie Mbarga (Passager)',
      type: 'Comportement inapproprié',
      description: 'Comportement déplacé durant le trajet.',
      date: '3 Fév 2026',
      status: 'pending',
      severity: 'high'
    },
    {
      id: 3,
      complainant: 'Alice Momo',
      against: 'David Talla (Conducteur)',
      type: 'Véhicule en mauvais état',
      description: 'Véhicule sale et climatisation défectueuse.',
      date: '2 Fév 2026',
      status: 'resolved',
      severity: 'low'
    }
  ];

  const filteredComplaints = complaints.filter(c => 
    selectedStatus === 'all' || c.status === selectedStatus
  );

  const getSeverityColor = (severity: string) => {
    switch (severity) {
      case 'high': return 'bg-destructive/10 text-destructive border-destructive/20';
      case 'medium': return 'bg-accent/10 text-accent border-accent/20';
      default: return 'bg-muted text-muted-foreground';
    }
  };

  return (
    <div className="min-h-screen bg-background pb-24">
      <Header onBack={onBack} title="Gestion des plaintes" />

      <div className="px-4 py-6 space-y-6">
        {/* Stats */}
        <div className="grid grid-cols-3 gap-3">
          <Card className="text-center bg-destructive/5">
            <p className="text-2xl font-bold text-destructive">
              {complaints.filter(c => c.status === 'pending').length}
            </p>
            <p className="text-xs text-muted-foreground">En attente</p>
          </Card>
          <Card className="text-center bg-primary/5">
            <p className="text-2xl font-bold text-primary">
              {complaints.filter(c => c.status === 'resolved').length}
            </p>
            <p className="text-xs text-muted-foreground">Résolues</p>
          </Card>
          <Card className="text-center">
            <p className="text-2xl font-bold">{complaints.length}</p>
            <p className="text-xs text-muted-foreground">Total</p>
          </Card>
        </div>

        {/* Filter */}
        <div className="flex gap-2">
          <button
            onClick={() => setSelectedStatus('pending')}
            className={`px-4 py-2 rounded-xl transition-all ${
              selectedStatus === 'pending'
                ? 'bg-destructive text-white'
                : 'bg-muted text-muted-foreground'
            }`}
          >
            En attente
          </button>
          <button
            onClick={() => setSelectedStatus('resolved')}
            className={`px-4 py-2 rounded-xl transition-all ${
              selectedStatus === 'resolved'
                ? 'bg-primary text-white'
                : 'bg-muted text-muted-foreground'
            }`}
          >
            Résolues
          </button>
          <button
            onClick={() => setSelectedStatus('all')}
            className={`px-4 py-2 rounded-xl transition-all ${
              selectedStatus === 'all'
                ? 'bg-primary text-white'
                : 'bg-muted text-muted-foreground'
            }`}
          >
            Toutes
          </button>
        </div>

        {/* Complaints List */}
        <div>
          <h3 className="font-bold mb-4">
            Plaintes ({filteredComplaints.length})
          </h3>
          
          <div className="space-y-4">
            {filteredComplaints.map((complaint) => (
              <Card 
                key={complaint.id} 
                className={complaint.status === 'pending' ? 'border-destructive/20' : ''}
              >
                <div className="space-y-4">
                  {/* Header */}
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <div className="flex items-center gap-2 mb-2">
                        <AlertCircle className={`w-5 h-5 ${
                          complaint.severity === 'high' ? 'text-destructive' :
                          complaint.severity === 'medium' ? 'text-accent' :
                          'text-muted-foreground'
                        }`} />
                        <h4 className="font-semibold">{complaint.type}</h4>
                      </div>
                      <p className="text-sm text-muted-foreground mb-1">
                        De: {complaint.complainant}
                      </p>
                      <p className="text-sm text-muted-foreground">
                        Contre: {complaint.against}
                      </p>
                    </div>

                    <div className="flex flex-col items-end gap-2">
                      <div className={`px-2 py-1 rounded-lg text-xs font-semibold ${getSeverityColor(complaint.severity)}`}>
                        {complaint.severity === 'high' ? 'Urgent' :
                         complaint.severity === 'medium' ? 'Moyen' : 'Faible'}
                      </div>
                      <span className="text-xs text-muted-foreground">{complaint.date}</span>
                    </div>
                  </div>

                  {/* Description */}
                  <div className="p-3 bg-muted/50 rounded-xl">
                    <p className="text-sm">{complaint.description}</p>
                  </div>

                  {/* Status Badge */}
                  <div className="flex items-center gap-2">
                    {complaint.status === 'pending' ? (
                      <div className="flex items-center gap-2 text-sm text-destructive">
                        <Clock className="w-4 h-4" />
                        <span>En attente de traitement</span>
                      </div>
                    ) : (
                      <div className="flex items-center gap-2 text-sm text-primary">
                        <CheckCircle className="w-4 h-4" />
                        <span>Plainte résolue</span>
                      </div>
                    )}
                  </div>

                  {/* Actions */}
                  {complaint.status === 'pending' && (
                    <div className="flex gap-2 pt-2 border-t border-border">
                      <Button variant="outline" size="sm" className="flex-1">
                        <MessageCircle className="w-4 h-4 mr-2" />
                        Contacter
                      </Button>
                      <Button variant="outline" size="sm" className="flex-1">
                        <X className="w-4 h-4 mr-2" />
                        Rejeter
                      </Button>
                      <Button size="sm" className="flex-1">
                        <CheckCircle className="w-4 h-4 mr-2" />
                        Résoudre
                      </Button>
                    </div>
                  )}
                </div>
              </Card>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
