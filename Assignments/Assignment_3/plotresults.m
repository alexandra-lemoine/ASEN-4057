function [] = plotresults( e_i,e_q, p_i, p_q,l_i, l_q, carrierfq, codefq, hand_codfq, hand_intfq, hand_corres, hand_promi, hand_promq)  
    
%{
Modified: plotresults modified to plot to the gui window, function handles
are used in all functions used for plots
    Inputs: 
            outputs calculated in findandtrack.m
            variables starting with 'hand_' correspond to a UIaxes
            featured in the gui
            
    Outputs: 
        only plots
%}
 
        plot(hand_corres,p_i .^2 + p_q .^ 2, 'g.-') %plot to assigned UIaxes
        hold(hand_corres,'on'); %hold figure in gui
        
        plot(hand_corres,e_i .^2 + e_q .^ 2, 'bx-') 
        hold(hand_corres,'on');
        plot(hand_corres,l_i .^2 + l_q .^ 2, 'r+-')
        xlabel(hand_corres,'milliseconds')
        ylabel(hand_corres,'amplitude')
        title(hand_corres,'Correlation Results')
        legend(hand_corres,'prompt','early','late')
        hold(hand_corres,'off'); 
        
        plot(hand_promi,p_i)
        hold(hand_promi,'on');
        xlabel(hand_promi,'milliseconds')
        ylabel(hand_promi,'amplitude')
        title(hand_promi,'Prompt I Channel')
        hold(hand_promi,'off');
        
        plot(hand_promq,p_q)
       hold(hand_promq,'on');
        xlabel(hand_promq,'milliseconds')
        ylabel(hand_promq,'amplitude')
        title(hand_promq,'Prompt Q Channel')
        hold(hand_promq,'off');
        
        plot(hand_codfq,1.023e6 - codefq)
        hold(hand_codfq,'on');
        xlabel(hand_codfq,'milliseconds')
        ylabel(hand_codfq,'Hz')
        title(hand_codfq,'Tracked Code Frequency (Deviation from 1.023MHz)')
        hold(hand_codfq,'off');
        
        plot(hand_intfq,carrierfq)
        hold(hand_intfq,'on');
        xlabel(hand_intfq,'milliseconds')
        ylabel(hand_intfq,'Hz')
        title(hand_intfq,'Tracked Intermediate Frequency')
        hold(hand_intfq,'off');
end
