## printf

```
c      character               Integral
d      decimal                 Integral
o      octal                   Integral
x      hexadecimal             Integral
X      hexadecimal             Integral
b      binary                  Integral
u      unsigned decimal        Integral
f      floating point          RealFloat
F      floating point          RealFloat
g      general format float    RealFloat
G      general format float    RealFloat
e      exponent format float   RealFloat
E      exponent format float   RealFloat
s      string                  String
v      default format          any type

```

```
-- GHCI
printf "%.2g\n" pi
```

```
main = printf "%.2g\n" (pi::Double) :: IO()
```
