CCIP
=========

For the old script version see:  
https://github.com/eRazeri/CCIP/tree/old  

For the original script version see:  
https://github.com/jonimake/arma-ccip  

NOTICE:
This is a heavy WIP!

This addon is a CCIP (continously computed impact point) solver for aircrafts in ArmA 3. It is a client side addon that only runs on clients. The addon calculates the approximate impact point of the currently selected weapon in the aircraft. It is an approximation, so there will be a small degree of error between the calculated impact point and the real impact point.

The script only calculates the impact point. There is just a crude cross on the HUD along with distance text to indicate the computed impact point. HUD development was never a focus of this project but that might change.

How does it work?
--
Approximation is done by using Euler's method to solve the projectile  motion.

The following ammo types are supported more or less:

  - MissileCore and its sub-types.
  - BulletCore and its sub-types.
  - BombCore and its sub-types.

Configuring allowed weapons
--
In order to enable CCIP on a certain aircraft, you have to define all CCIP compatible weapons in a config for that vehicle. You can see examples within.

Already configured vehicles:
=========
Vanilla:  
AH-9 Pawnee  
A-164 Wipeout  
To-199 Neophron  
A-143 Buzzard  

Additional third party addon support:  
[F/A-18 Super Hornet](http://forums.bistudio.com/showthread.php?164308-F-A-18-Super-Hornet-for-ARMA-3)   
[F/A-18X Black Wasp] (http://forums.bistudio.com/showthread.php?184750-F-a-18x-black-wasp)  
[Su-35 S Flanker E] (http://forums.bistudio.com/showthread.php?164308-F-A-18-Super-Hornet-and-Su-35S-Flanker-E&p=2503784&viewfull=1#post2503784)  
[JAS39G] (https://github.com/eRazeri)  
[F-35C] (https://github.com/RealityGaming/OK_F_35C)  
[Peral A-10C] (http://forums.bistudio.com/showthread.php?172682-A-10C-for-Arma-3)  
[STI A-10A] (http://forums.bistudio.com/showthread.php?175871-STI-Addons)  

Debugging
=========
There`s two functions for debugging:  
(vehicle player) setVariable ["CCIP_DebugLine", true];//Enable line draw  
(vehicle player) setVariable ["CCIP_CCIP_DebugWeaponPos", true];//Spawn a sphere at the starting point  
