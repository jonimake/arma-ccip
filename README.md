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


License 
--
This is a modified version of the original work.

Original author:
Joni Mäkelä

Author for the modified version:
eRazeri

MIT License:

Copyright (C) 2014 Joni Mäkelä

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
