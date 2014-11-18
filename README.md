CCIP
=========

For the old script version see:  
https://github.com/eRazeri/CCIP/tree/old  

NOTICE:
This is a heavy WIP and will probably not work as of yet!

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
