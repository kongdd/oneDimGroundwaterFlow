# One dim groundwater flow simulation,  kriging and idw interpolatiaon
kongdd  
Friday, January 16, 2015  

> kongdd  
> email: kongdd@mail2.sysu.edu.cn  
> Sun Yat-Sen University, Guangzhou, China  

### Problem 1

The ground flow equation for 1D heterogeneous, isotropic porous medium with a constant aquifer thickness is given by:  
Where h(x,t) is the hydraulic head, T(x) is the transmissivity, and S is the storativity. The boundary conditions imposed are constant head hL (15m) and hR (5m) at the left and right ends of soil column, respectively. The initial condition is 0 or random number at each node. The length of aquifer is 1m (L=1m). The storativity is 1 (S = 1).  
Develop a MATLAB program which can handle a heterogeneous transmissivity field using the implicit method.  

1. Test the program for the case of homogenous parameters, and compare the results with the results generated from flow equation with homogenous transmissivity field (i.e.,  )  

![alt figure1](oneDimGroundWaterFlow/Het_figure1.2.png)

2. Test the program for patch- heterogeneous T field, which comprises a two-zone T field with a fivefold difference in transmissivity (T1=5T2, T1=0.01m2s-1, T2=0.002m2s-1 ; or, T1=0.2T2, T1=0.002m2s-1, T2=0.01m2s-1) and an interface in the middle of the domain.

![alt figure2](oneDimGroundWaterFlow/Hom_figure1.1.png)

### Problem 2  
Use rainfall from 8 stations to estimate the annual rainfall for 6 stations using the kriging ordinary methods.
The locations of the 8 stations where rainfall is available are as follows:

No. | station name  | latitude  | logitude
--- | ------------- | --------- | --------
1	  | boulder       |	40.033    |	105.267
2 	| castle  | 39.383  | 104.867
3	  | green9ne  |	39.267  |	104.750
4	  | lawson	 | 39.767 |	105.633
5	  | longmont  |	40.252  |	105.150
6	  | manitou	|  38.850 |	104.933
7	  | parker	 | 39.533 |	104.650
8	  | woodland  |	39.100  |	105.083

The 15-year rainfall records for 8 the stations are available in the Excel file “Rain_8Stations_Known.xls”
The locations of the 6 stations where rainfall need to be estimated are as follows:

No. | station name  | latitude  | logitude
--- | ------------- | --------- | --------
1	  | byers         | 39.750    |	104.133
2 	| estes         |	40.383	  | 105.517
3	  | golden	      | 39.700	  | 105.217
4	  | green9se	    | 39.100	  | 104.733
5	  | lakegeor	    | 38.917	  | 105.483
6	  | morrison	    | 39.650	  | 105.200

The annual rainfall for 6 the stations are available in the Excel file “AnnualRain_6Stations_ToBeEstimated.xls”. This will be used to calculate the estimate error by using different interpolation methods

1)	For each of 6 stations (i.e., byers, estes, golden, green9se, lakegeor, and morrison) where the annual will be estimated, estimate the annual rainfall based on rainfall at 8 stations (i.e., boulder, castle, green9ne, lawson, longmont, manitou, parker and woodland) using the kriging method.
2)	Estimate the annual rainfall using the inverse-distance-square method and the arithmetic mean method, and compare the error from the kriging method.
3)	Calculate the error variance for kriging method at each of 6 stations

  Note: use an exponential function to model covariance:  , where a and b are parameters to be determined, and d is the distance between two points.


