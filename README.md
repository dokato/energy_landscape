# Energy landscape scripts

### Dependecies

Matlab > 2016 is required to run this code.

You need to have ELAT software in you matlab path: https://sites.google.com/site/ezakitakahiro/software.

### Data preprocessing
To run it you should have your MEG data in source space (e.g using LMCV Beamforming) in `.mat` format in `data` folder relative to this path.

### Pipeline

1. Start with running: `run_all.m` and set parameters at the top of the script according to your needs.
2. `make_envelope.m` - computes Hilbert envelope of the signal in given frequency.
3. `bestThreshold.m` looks for the best threshold that maximized `r` (relative KL divergence betweem pMEM and empirical data).
4. `enerland_simulation.m` simulated the data based on the basinGraph. It used Metropolis-Hastings algorithm implemented in `metrophastings.m`.
5. `plot_3d_activations.m` uses `SourceMesh` package to plot 3D activation of brain regions.
6. `shuffleJh.m` is used for bootstraping for statistical analysis of the energy values.

#### Literature

- http://rsta.royalsocietypublishing.org/content/375/2096/20160287
- https://www.nature.com/articles/ncomms5765
