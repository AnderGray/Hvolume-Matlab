# Hvolume

[![View Hvolume on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/77726-hvolume)

Calculates the *H-volume* (generalised volume) of an *n-box* in a space with some measure *H*. Usefull in probability theory, the *H*-volume computes the probability measure within some *n*-box from a multivartiate cdf *H*. 

An n-box *J* is a hyper-rectangle made from the carteesian product of n intervals:

![Carteesian product](https://i.imgur.com/KYCAF0O.png)

The two dimensional calculation is:

![2D formula](https://i.imgur.com/lQHflWo.png)

![H-volume illustration 2D](https://i.imgur.com/F8Xgwd1.png)

The general formula is:

![General formula for H-volume](https://i.imgur.com/ZTya5hf.png)

where the sum is taken over every vertex of *J*. 

Code
---
```MATLAB
Vol = Hvolume(measure, J1, J2, .. , Jn)
```
*measure* is an anonymous function of dimension *n* and *J1* to *Jn* are *n* intervals defining the *n*-box.

1D
```MATLAB
>> C1 = @(x) unifcdf(x,0,1);
>> H1 = Hvolume(C1,[0,0.5])

H1 =

    0.5000
    
```
2D
```MATLAB
>> Rho2 =[1, 0; 0, 1];
>> C2 = @(x) copulacdf('Gaussian', [x(1), x(2)],Rho2);
>> H2 = Hvolume(C2,[0,0.5],[0,0.5])

H2 =

    0.2500

```
3D
```MATLAB
>> Rho3 =eye(3);
>> C3 = @(x) copulacdf('Gaussian', [x(1),x(2),x(3)],Rho3);
>> H3 = Hvolume(C3,[0,0.5], [0,0.5], [0,0.5])

H3 =

    0.1250
    
```
4D
```MATLAB
>> Rho4 =eye(4);
>> C4 = @(x) copulacdf('Gaussian', [x(1),x(2),x(3),x(4)],Rho4);
>> H4 = Hvolume(C4,[0,0.5], [0,0.5], [0,0.5], [0,0.5])

H4 =

    0.0625
    
```
References
---

* *Schweizer, B. and Sklar, A., 2011. Probabilistic metric spaces. Courier Corporation.*

* *Ferson, S., R. Nelsen, J. Hajagos, D. Berleant, J. Zhang, W.T. Tucker, L. Ginzburg and W.L. Oberkampf. 2004. Dependence in Probabilistic Modeling, Dempster-Shafer Theory, and Probability Bounds Analysis. Sandia National Laboratories, SAND2004-3072, Albuquerque, NM*
