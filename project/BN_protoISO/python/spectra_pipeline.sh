#!/bin/bash

RELEASE_DIR="/global/cfs/cdirs/sobs/lat-iso/ps/BN/"
PROJECT_DIR="/global/homes/m/merrydup/PSpipe/project/BN_protoISO/"

PARAMFILE=${PROJECT_DIR}paramfiles/global_dr6v4xlegacyxso_bossn_20250716.dict


# the number of ntasks is not optimal as different scripts may have different number of mpi tasks.
run_pre() {
    OMP_NUM_THREADS=48 srun -n 5 -c 48 --cpu-bind=cores python ${PROJECT_DIR}python/get_windows.py $PARAMFILE
    OMP_NUM_THREADS=48 srun -n 5 -c 48 --cpu-bind=cores python ${PROJECT_DIR}python/get_mcm_and_bbl.py $PARAMFILE
}

run_post() {
    OMP_NUM_THREADS=48 srun -n 5 -c 48 --cpu-bind=cores python ${PROJECT_DIR}python/get_alms.py $PARAMFILE
    OMP_NUM_THREADS=48 srun -n 5 -c 48 --cpu-bind=cores python ${PROJECT_DIR}python/get_spectra_from_alms.py $PARAMFILE
}

case "$1" in
    pre)
        echo "Running get_windows.py and get_mcm_and_bbl.py"
        run_pre
        ;;
    post)
        echo "Running get_alm.py and get_spectra_from_alms.py using existing mcms and windows folders."
        run_post
        ;;
    *)
        echo "Running whole spectra pipeline using $PARAMFILE"
        run_pre
        run_post
        ;;
esac