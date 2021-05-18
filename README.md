# SO-WISE observational suite 
## Derived from B-SOSE, SO-CHIC, and others

Full B-SOSE data on BAS HPC:
```
/data/expose/so-wise/so-wise-obs/data_bsose/datasets/
```
Full SO-CHIC data on BAS HPC:
```
/data/expose/so-wise/so-wise-obs/data_so-chic/
```

A state estimate is constrained by a suite of observations. Here I'll record my progress with preparing the observational suite for use in the state estimation framework. 

MITgcm uses MITprof to create profile collections, which are then used by the state estimation packages to constrain the numerical solution. So as a first step, we have to prepare the data to be read and processed by MITprof.

### 1.1: Scripps data prep method
The Scripps group uses the following procedure to prepare the data:

- Convert temperature to potential temperature
- Covert salinities to practical salinities if needed
- Establish N standard levels (they use N=97). These levels don't have to be the same as the MITgcm model levels.
- Preprocess each profile onto those N levels, using bins +/- 2m. Use nearest neighbor linear interpolation to bin the observations.
- Look at each profile manually, checking for errors.
- Call MITprof and write the collection out to NetCDF
- Something else (?) reads the NetCDF then assigns the weights
- Here is the master list for which datasets have been processed and updated: [http://sose.ucsd.edu/RESEARCH/Master.htm](http://sose.ucsd.edu/RESEARCH/Master.htm)

### 1.2: Procedure for moorings
Mooring data is a bit different:

Use the average pressure on each instrument to look for drifts
If high-frequency temporal data, pre-average to daily data

### 1.3: Complete set of constraints used by B-SOSE
Matt very kindly provided the complete set of constraints. How cool! Here is everything:

http://sose.ucsd.edu/SO6/DATA/

And here is the example of Argo, with weights and things. We can look in the Weddell Sea:

http://sose.ucsd.edu/SO6/ITER133/PROF/

For more info, check out Figure 15 of this paper:

http://sose.ucsd.edu/MyPDFs/A.I.39_Chamberlain_et_al-2018-Journal_of_Geophysical_Research__Oceans.pdf

### 1.4: Known data that is missing from the B-SOSE suite

- Mooring data, especially in the Weddell Gyre region
- Any SO-CHIC instruments and campaigns, gliders
- Any ORCHESTRA instruments and campaigns, gliders
- Perhaps some of the BODC and SO-CHIC data (may overlap with the above three)
- FISS moorings and under-ice profiles
