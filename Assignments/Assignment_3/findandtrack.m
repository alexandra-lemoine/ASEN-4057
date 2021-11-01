function [e_i,e_q,p_i,p_q,l_i,l_q,carrierfq,codefq] = findandtrack(prn, msec_to_process, fs, intfreq)
    
%{
Modified: findandtrack to return values used in plotresults
    Inputs: prn: GPS #
            msec_to_process: msec of data 
            fs: sampling frequency
            intfreq: intermediate frequency
    Outputs: 
        e_i,e_q,p_i,p_q,l_i,l_q,carrierfq,codefq
        these are all used in plotresults and will be returned to be used
        in the application
%}


    %findandtrack
    %basic functionality to do GPS Bistatic Reflection Processing
    disp('GPS Bistatic Processing')
    corrspacing=-28.1:0.05:1.1;  %correlator measurement spacing
    %%input parameters to set (specific to data file)
    %the following are now hard coded along with the complex data format
    %filename='GPSantennaUp.sim';  %direct file
    %filename2='GPSantennaDown.sim';  %reflected file

    %%first open the direct data file and get first block of data to work with
    fid=fopen('GPSantennaUp.sim','rb');  %open binary file containing direct data
    rawdat=(fread(fid,2000000,'schar'))';  %read in 2M samples
    rawdat=rawdat(1:2:end)+ i .* rawdat(2:2:end);  %convert to complex IQ pairs
    fclose(fid);  %close the file

    %%first do satellite acqusition and get approx code phase/freq estimate
    disp('Initiating GPS satellite acquisition...')
    [fq_est,cp_est,c_meas,testmat]=acq4(prn,intfreq,9000,rawdat,fs,4,0);
    disp(['  Acquisition Metric is: ',num2str(c_meas(1)),' (should be >2.0)']); 
    %refine the acqusition estimate to get better code phase/frequency
    [fq_est,cp_est,c_meas,testmat]=acq4(prn,fq_est,400,rawdat,fs,10,0);
    disp(['  Refined Acq Metric is: ',num2str(c_meas(1)),' (should be >2.0)']); 

    %%now do the main bistatic tracking/processing
    disp('Initiating GPS satellite signal tracking...')
    tstart=tic;  %start the timer
    [e_i,e_q,p_i,p_q,l_i,l_q,carrierfq,codefq] = ...
        gpstrackcorr(prn, cp_est, fq_est, fs, corrspacing, msec_to_process);
    toc(tstart);

    %%finished!
    disp('Finished!  Run scripts: corrplot.m or plotresults.m for results visualization')
end

