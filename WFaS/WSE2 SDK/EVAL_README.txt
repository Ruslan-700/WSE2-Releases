== INFO ==
The eval function is implemented using muParser (http://muparser.sourceforge.net)

== VARIABLES ==
Registers can be read by adding {regx} to the expression string. Registers cannot be written to. They are evaluated before the expression, and can be used to form variable names.
(feval, "@fp1={reg0}+{reg1}") => stores the sum of reg0 and reg1 into fp1
(feval, "@fp{reg0}=1") => stores 1 into floating point register x, where x is the value of reg0

Floating point registers can be read and written like normal variables (without using { and }).
(feval, "@fp1=fp2+fp3") => stores the sum of fp2 and fp3 into fp1

Position registers can be read and written like normal variables (without using { and })
To access the origin components of a position, append the component (x, y, z) to the register name
To access the transformation components of a position, append the vector abbreviation (side: s, front: f, up: u) and the component (x, y, z) to the register name
(feval, "@fp1=pos2x") => stores the x origin component of position register2 into floating point register 1
(feval, "@pos3fy=1") => sets the y component of front vector (y scale in a transformation matrix) of position register 3 to 1

Chaining expressions:
A single eval can have multiple expressions, separated by a comma.
(feval, "@fp1=1,fp2=3,fp3=3") => fp1, fp2 and fp3 will be set to 1, 2 and 3 respectively
(feval, "@pos0x=(pos1y*pos2z)-(pos1z*pos2y),pos0y=(pos1z*pos2x)-(pos1x*pos2z),pos0z=(pos1x*pos2y)-(pos1y*pos2x)") => Stores the cross product of the origins of pos1 and pos2 into the origin of pos0

== FUNCTIONS ==
Built-in functions:
sin(x): returns the sine of x
cos(x): returns the cosine of x
tan(x): returns the tangent of x
asin(x): returns the arcsine of x
acos(x): returns the arccosine of x
atan(x): returns the arctangent of x
sinh(x): returns the hyperbolic sine of x
cosh(x): returns the hyperbolic cosine of x
tanh(x): returns the hyperbolic tangent of x
asinh: returns the hyperbolic arcsine of x
acosh(x): returns the hyperbolic arccosine of x
atanh(x): returns the hyperbolic arctangent of x
log2(x): returns the logarithm to the base 2 of x
log10(x): returns the logarithm to the base 10 of x
log(x): returns the logarithm to the base 10 of x
ln(x): returns the logarithm to base e of x
exp(x): returns e raised to the power of x
sqrt(x): returns the square root of x
sign(x): returns -1 if x<0 or 1 if x>0
rint(x): returns x rounded to the nearest integer
abs(x): returns the absolute value of x
min(...): returns the minimum of all arguments
max(...): returns the maximum of all arguments
sum(...): returns the sum of all arguments
avg(...): returns the average of all arguments

Custom-defined functions:
deg2rad(x): converts x from degrees to radians
rad2deg(x): converts x from radians to degrees
floor(x): returns the floor of x
ceil(x): returns the ceiling of x
fmod(x, y): returns the remainder of x/y
atan2(y, x): returns the principal value of the arc tangent of y/x
clamp(x, min, max): returns x clamped between min and max (both inclusive)

== LICENSE ==
Copyright (c) 2011 Ingo Berg
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
