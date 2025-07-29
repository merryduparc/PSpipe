**************************
Computing proto-ISO BOSS-N spectra
**************************

Running the pipeline
-------------------------------------------------------

The dict file ``paramfiles/global_dr6v4xlegacyxso_bossn_20250716.dict`` is the one used to get all the ACTxLAT and LATxLAT spectra of proto-ISO BOSS-N observations. The maps where done before the fix of the polarization problem in i1 and i3 tubes.
The whole computation takes a little bit less than one hour, but you can easily modify the dict file to only compute the spectra you want (by changing "surveys" and "arrays").
This pipeline only runs windows, mcm, alms and spectra computations. It is very similar to the same part of ``ACT_DR6/dr6xplanck.rst``.

You can run each code independently in the same order as ``ACT_DR6/dr6xplanck.rst``, but you can also use ``spectra_pipeline.sh`` : 

.. code:: shell

    salloc --nodes 1 --qos interactive --time 01:00:00 --constraint cpu
    bash PSpipe/project/BN_protoISO/python/spectra_pipeline.sh
    # around 50min

Remember that this will create ``windows``, ``mcms``, ``alms`` ans ``spectra`` folders at the location you run this command.

You can also use it to run only the beginning or the end of the pipeline : 

.. code:: shell

    bash PSpipe/project/BN_protoISO/python/spectra_pipeline.sh pre
    # This will only compute windows and mcms (around 45min)
    bash PSpipe/project/BN_protoISO/python/spectra_pipeline.sh post
    # This will only compute alms and spectra using existing mcms and windows (around 5min)


Some details about the products
-------------------------------------------------------

Masks at ``/global/cfs/cdirs/sobs/lat-iso/ps/BN/masks`` are made by thresholding ivar BOSS-N maps, or from ACT DR6 (for point sources and galactic mask).
There are also 'restrictive' masks (with _restr suffix) for i3 and i6 tubes that have a more uneven coverage. These masks only cover the part of the patch that has a significantly better coverage.

The k-space filter used is also the same as ACT DR6.

Beams are gaussian at 2.2' for f090, 1.5' for f150 and 0.96' for f220.


