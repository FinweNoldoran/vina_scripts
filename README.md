# vina_scripts

Some scripts to run autodock vina on ZINC pdbqt libaries, and to return the top results with the best energy from each. This assumes you have autodock vina installed.

## RUN

First of all, make the script executable:

```
chmod 755 run.pl
```

Run assumes you are want to run autodock vina on a ZINC pdbqt library, for which the directory structure is:

```
library_name/pdbqt/pdbqt*
```
to run all compounds in every folder inside /pdbqt (e.g. pdbqt0, pbdqt1 etc.) type the following command:

```
./run.pl library_name
```

Run must be in the same directory as the ```library_name``` folder, it also requires the conf.txt file and the ```vina_screen_local.sh``` in it's directory. 

Run will then run the vina_screen_local.sh bash script in each folder, so you do not have to set up a screen for a new folder each time the last one finishes.

## Top

Top reports the top n scoring ligands, where n is 10 by default. Once again make it executable using the same command as for run.pl. 

Top assumes it is also in the same directory as run.pl. To run it:

```
./run.pl 15
```

will return the top 15 results, and their energies in kcal/mol. If you do not give run a number (like 15 in the example above), it will return the top ten results.
		