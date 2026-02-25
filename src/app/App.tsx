import React, { useState } from 'react';
import { Home, Car, User, MapPin, Calendar, History, Users, Shield, DollarSign, AlertCircle } from 'lucide-react';
import { BottomNav } from './components/BottomNav';

// Passenger Components
import { Onboarding } from './components/passenger/Onboarding';
import { PhoneAuth } from './components/passenger/PhoneAuth';
import { PassengerHome } from './components/passenger/PassengerHome';
import { RideBooking } from './components/passenger/RideBooking';
import { RideTracking } from './components/passenger/RideTracking';
import { Payment } from './components/passenger/Payment';
import { ScheduledRoutes } from './components/passenger/ScheduledRoutes';
import { RideHistory } from './components/passenger/RideHistory';

// Driver Components
import { DriverDashboard } from './components/driver/DriverDashboard';
import { CreateRide } from './components/driver/CreateRide';
import { CreateScheduledRide } from './components/driver/CreateScheduledRide';
import { RideRequests } from './components/driver/RideRequests';

// Admin Components
import { AdminDashboard } from './components/admin/AdminDashboard';
import { UserManagement } from './components/admin/UserManagement';
import { ComplaintManagement } from './components/admin/ComplaintManagement';
import { PricingControl } from './components/admin/PricingControl';

type UserRole = 'passenger' | 'driver' | 'admin';
type Screen = string;

export default function App() {
  const [userRole, setUserRole] = useState<UserRole | null>(null);
  const [isOnboarded, setIsOnboarded] = useState(false);
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [currentScreen, setCurrentScreen] = useState<Screen>('home');
  const [navTab, setNavTab] = useState('home');

  // Role Selection Screen
  if (!userRole) {
    return (
      <div className="min-h-screen bg-gradient-to-b from-primary/5 to-white flex flex-col items-center justify-center px-6">
        <div className="text-center mb-12">
          <div className="w-20 h-20 bg-primary rounded-3xl flex items-center justify-center mx-auto mb-6">
            <Car className="w-10 h-10 text-white" />
          </div>
          <h1 className="text-3xl font-bold mb-2">Co-Voiturage Cameroun</h1>
          <p className="text-muted-foreground">Sélectionnez votre type de compte</p>
        </div>

        <div className="w-full max-w-md space-y-4">
          <button
            onClick={() => setUserRole('passenger')}
            className="w-full p-6 bg-white border-2 border-border rounded-2xl hover:border-primary hover:bg-primary/5 transition-all"
          >
            <div className="flex items-center gap-4">
              <div className="w-14 h-14 bg-primary/10 rounded-2xl flex items-center justify-center flex-shrink-0" style={{ backgroundColor: 'rgb(59 130 246 / 0.1)' }}>
                <User className="w-7 h-7" style={{ color: '#3b82f6' }} />
              </div>
              <div className="text-left">
                <h3 className="font-bold text-lg">Passager</h3>
                <p className="text-sm text-muted-foreground">Réserver des trajets partagés</p>
              </div>
            </div>
          </button>

          <button
            onClick={() => setUserRole('driver')}
            className="w-full p-6 bg-white border-2 border-border rounded-2xl hover:border-primary hover:bg-primary/5 transition-all"
          >
            <div className="flex items-center gap-4">
              <div className="w-14 h-14 bg-primary/10 rounded-2xl flex items-center justify-center flex-shrink-0">
                <Car className="w-7 h-7 text-primary" />
              </div>
              <div className="text-left">
                <h3 className="font-bold text-lg">Conducteur</h3>
                <p className="text-sm text-muted-foreground">Proposer des trajets et gagner</p>
              </div>
            </div>
          </button>

          <button
            onClick={() => setUserRole('admin')}
            className="w-full p-6 bg-white border-2 border-border rounded-2xl hover:border-primary hover:bg-primary/5 transition-all"
          >
            <div className="flex items-center gap-4">
              <div className="w-14 h-14 rounded-2xl flex items-center justify-center flex-shrink-0" style={{ backgroundColor: 'rgb(139 92 246 / 0.1)' }}>
                <Shield className="w-7 h-7" style={{ color: '#8b5cf6' }} />
              </div>
              <div className="text-left">
                <h3 className="font-bold text-lg">Administrateur</h3>
                <p className="text-sm text-muted-foreground">Gérer la plateforme</p>
              </div>
            </div>
          </button>
        </div>

        <button
          onClick={() => {
            setUserRole('passenger');
            setIsOnboarded(true);
            setIsAuthenticated(true);
          }}
          className="mt-8 text-muted-foreground text-sm"
        >
          Ignorer et voir la démo
        </button>
      </div>
    );
  }

  // Onboarding Flow
  if (!isOnboarded) {
    return (
      <Onboarding
        onComplete={() => setIsOnboarded(true)}
      />
    );
  }

  // Authentication Flow
  if (!isAuthenticated) {
    return (
      <PhoneAuth
        onComplete={() => setIsAuthenticated(true)}
        onBack={() => setIsOnboarded(false)}
      />
    );
  }

  // PASSENGER INTERFACE
  if (userRole === 'passenger') {
    // Passenger Navigation
    const passengerNavItems = [
      { icon: <Home className="w-6 h-6" />, label: 'Accueil', id: 'home', active: navTab === 'home', onClick: () => { setNavTab('home'); setCurrentScreen('home'); } },
      { icon: <Calendar className="w-6 h-6" />, label: 'Programmés', id: 'scheduled', active: navTab === 'scheduled', onClick: () => { setNavTab('scheduled'); setCurrentScreen('scheduled'); } },
      { icon: <History className="w-6 h-6" />, label: 'Historique', id: 'history', active: navTab === 'history', onClick: () => { setNavTab('history'); setCurrentScreen('history'); } },
      { icon: <User className="w-6 h-6" />, label: 'Profil', id: 'profile', active: navTab === 'profile', onClick: () => { setNavTab('profile'); setCurrentScreen('profile'); } }
    ];

    return (
      <>
        {currentScreen === 'home' && (
          <PassengerHome
            onBookRide={() => setCurrentScreen('booking')}
            onViewScheduledRoutes={() => setCurrentScreen('scheduled')}
            onViewHistory={() => setCurrentScreen('history')}
          />
        )}
        {currentScreen === 'booking' && (
          <RideBooking
            onBack={() => setCurrentScreen('home')}
            onConfirmBooking={() => setCurrentScreen('payment')}
          />
        )}
        {currentScreen === 'payment' && (
          <Payment
            onBack={() => setCurrentScreen('booking')}
            onPaymentComplete={() => setCurrentScreen('tracking')}
          />
        )}
        {currentScreen === 'tracking' && (
          <RideTracking
            onBack={() => setCurrentScreen('home')}
            onCompleteRide={() => setCurrentScreen('home')}
          />
        )}
        {currentScreen === 'scheduled' && (
          <ScheduledRoutes
            onBack={() => setCurrentScreen('home')}
            onBookRoute={() => setCurrentScreen('payment')}
          />
        )}
        {currentScreen === 'history' && (
          <RideHistory
            onBack={() => setCurrentScreen('home')}
          />
        )}
        {currentScreen === 'profile' && (
          <div className="min-h-screen bg-background pb-24 flex items-center justify-center">
            <div className="text-center px-6">
              <div className="w-20 h-20 bg-primary/10 rounded-full flex items-center justify-center mx-auto mb-4">
                <User className="w-10 h-10 text-primary" />
              </div>
              <h2 className="text-xl font-bold mb-2">Profil Passager</h2>
              <p className="text-muted-foreground mb-6">Gérez vos informations personnelles</p>
              <button
                onClick={() => {
                  setUserRole(null);
                  setIsOnboarded(false);
                  setIsAuthenticated(false);
                }}
                className="px-6 py-3 bg-primary text-white rounded-xl"
              >
                Changer de rôle
              </button>
            </div>
          </div>
        )}
        <BottomNav items={passengerNavItems} />
      </>
    );
  }

  // DRIVER INTERFACE
  if (userRole === 'driver') {
    // Driver Navigation
    const driverNavItems = [
      { icon: <Home className="w-6 h-6" />, label: 'Accueil', id: 'home', active: navTab === 'home', onClick: () => { setNavTab('home'); setCurrentScreen('home'); } },
      { icon: <Users className="w-6 h-6" />, label: 'Demandes', id: 'requests', active: navTab === 'requests', onClick: () => { setNavTab('requests'); setCurrentScreen('requests'); } },
      { icon: <Calendar className="w-6 h-6" />, label: 'Programmés', id: 'scheduled', active: navTab === 'scheduled', onClick: () => { setNavTab('scheduled'); setCurrentScreen('scheduled'); } },
      { icon: <User className="w-6 h-6" />, label: 'Profil', id: 'profile', active: navTab === 'profile', onClick: () => { setNavTab('profile'); setCurrentScreen('profile'); } }
    ];

    return (
      <>
        {currentScreen === 'home' && (
          <DriverDashboard
            onCreateRide={() => setCurrentScreen('create-ride')}
            onCreateScheduledRide={() => setCurrentScreen('create-scheduled')}
            onViewRideRequests={() => setCurrentScreen('requests')}
          />
        )}
        {currentScreen === 'create-ride' && (
          <CreateRide
            onBack={() => setCurrentScreen('home')}
            onPublishRide={() => setCurrentScreen('home')}
          />
        )}
        {currentScreen === 'create-scheduled' && (
          <CreateScheduledRide
            onBack={() => setCurrentScreen('home')}
            onCreateSchedule={() => setCurrentScreen('home')}
          />
        )}
        {currentScreen === 'requests' && (
          <RideRequests onBack={() => setCurrentScreen('home')} />
        )}
        {currentScreen === 'scheduled' && (
          <div className="min-h-screen bg-background pb-24 flex items-center justify-center">
            <div className="text-center px-6">
              <Calendar className="w-16 h-16 text-primary mx-auto mb-4" />
              <h2 className="text-xl font-bold mb-2">Mes trajets programmés</h2>
              <p className="text-muted-foreground">Gérez vos trajets récurrents</p>
            </div>
          </div>
        )}
        {currentScreen === 'profile' && (
          <div className="min-h-screen bg-background pb-24 flex items-center justify-center">
            <div className="text-center px-6">
              <div className="w-20 h-20 bg-primary/10 rounded-full flex items-center justify-center mx-auto mb-4">
                <Car className="w-10 h-10 text-primary" />
              </div>
              <h2 className="text-xl font-bold mb-2">Profil Conducteur</h2>
              <p className="text-muted-foreground mb-6">Gérez vos informations et véhicule</p>
              <button
                onClick={() => {
                  setUserRole(null);
                  setIsOnboarded(false);
                  setIsAuthenticated(false);
                }}
                className="px-6 py-3 bg-primary text-white rounded-xl"
              >
                Changer de rôle
              </button>
            </div>
          </div>
        )}
        <BottomNav items={driverNavItems} />
      </>
    );
  }

  // ADMIN INTERFACE
  if (userRole === 'admin') {
    // Admin Navigation
    const adminNavItems = [
      { icon: <Home className="w-6 h-6" />, label: 'Accueil', id: 'home', active: navTab === 'home', onClick: () => { setNavTab('home'); setCurrentScreen('home'); } },
      { icon: <Users className="w-6 h-6" />, label: 'Utilisateurs', id: 'users', active: navTab === 'users', onClick: () => { setNavTab('users'); setCurrentScreen('users'); } },
      { icon: <AlertCircle className="w-6 h-6" />, label: 'Plaintes', id: 'complaints', active: navTab === 'complaints', onClick: () => { setNavTab('complaints'); setCurrentScreen('complaints'); } },
      { icon: <DollarSign className="w-6 h-6" />, label: 'Tarifs', id: 'pricing', active: navTab === 'pricing', onClick: () => { setNavTab('pricing'); setCurrentScreen('pricing'); } }
    ];

    return (
      <>
        {currentScreen === 'home' && (
          <AdminDashboard
            onManageUsers={() => setCurrentScreen('users')}
            onMonitorRides={() => setCurrentScreen('rides')}
            onManageComplaints={() => setCurrentScreen('complaints')}
            onPricingControl={() => setCurrentScreen('pricing')}
          />
        )}
        {currentScreen === 'users' && (
          <UserManagement onBack={() => setCurrentScreen('home')} />
        )}
        {currentScreen === 'complaints' && (
          <ComplaintManagement onBack={() => setCurrentScreen('home')} />
        )}
        {currentScreen === 'pricing' && (
          <PricingControl onBack={() => setCurrentScreen('home')} />
        )}
        {currentScreen === 'rides' && (
          <div className="min-h-screen bg-background pb-24 flex items-center justify-center">
            <div className="text-center px-6">
              <Car className="w-16 h-16 text-primary mx-auto mb-4" />
              <h2 className="text-xl font-bold mb-2">Suivi des trajets</h2>
              <p className="text-muted-foreground">Surveillez tous les trajets en temps réel</p>
            </div>
          </div>
        )}
        <BottomNav items={adminNavItems} />
        
        {/* Admin Back Button */}
        <button
          onClick={() => {
            setUserRole(null);
            setIsOnboarded(false);
            setIsAuthenticated(false);
          }}
          className="fixed top-4 right-4 z-50 px-4 py-2 bg-white border border-border rounded-xl text-sm hover:bg-muted transition-colors"
        >
          Changer de rôle
        </button>
      </>
    );
  }

  return null;
}
