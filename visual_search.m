function [] =visual_search()
    plotting_matrix_feat = [];
    plotting_matrix_conj = [];
    set_size_list = [4 8 12 16];
    
    for i=1:length(set_size_list)
        set_size = set_size_list(i);

        correct = 0;
        trial = 1;
        RT_conj = [];
        RT_feat = [];
        n = 6; 
        numberOfOnes = n/2;
        indexes = randperm(n); 
        x = zeros(1, n); % start off with all zeros.
        x(indexes(1:numberOfOnes)) = 1; % half of them, at random, are 1
       

        % pop out feature
        while trial < 7
            h = figure;
            hold on;
            i=1;
             
            while i < set_size
                p = (0.9-0.1).*rand(4,2);
                axis([0 1 0 1]) 
                plot(p(3,1), p(3,2),'ob', 'MarkerSize',10); %blue o point
                plot(p(4,1), p(4,2), 'xb', 'MarkerSize',10); % blue x point  
                i = i+1;
            end
            if x(trial)
                plot(p(2,1), p(2,2),'or', 'MarkerSize',10); %red o point // target is here 
                plot(p(4,1), p(4,2), 'xb', 'MarkerSize',10); % blue x to control for number


            end
            hold off
            tic;
            pause;
            h725 = get(h, 'CurrentCharacter');
            elapsedTime = toc;
            
            %correct input
            if strcmp(h725,'y') & x(trial) | strcmp(h725,'n') & ~x(trial)
                correct = correct + 1; 
                RT_feat = [RT_feat, elapsedTime];
                plotting_matrix_feat = [plotting_matrix_feat ; i elapsedTime];
            end
            
        trial = trial +1;
        end
 
    end
    
    uc1 = unique(plotting_matrix_feat(:,1)) ;
    mc2 = accumarray(plotting_matrix_feat(:,1), plotting_matrix_feat(:,2), [], @mean);
    newData_feat = [uc1, mc2(uc1)];
    
 
    
    %conjunction feature
    for i=1:length(set_size_list)
        set_size = set_size_list(i);
    
    
        correct = 0;
        trial = 1;
        RT_conj = [];
        n = 6;
        numberOfOnes = n/2;
        indexes = randperm(n);
        x = zeros(1, n);
        x(indexes(1:numberOfOnes)) = 1;
       
        while trial < 7
            h = figure;
            hold on
            i=1;
            while i < set_size
                p = (0.9-0.1).*rand(4,2);
                axis([0 1 0 1]);
                plot(p(3,1), p(3,2),'ob', 'MarkerSize',10); %blue o point
                plot(p(4,1), p(4,2), 'xb', 'MarkerSize',10); % blue x point 
                plot(p(1,1), p(1,2),'xr','MarkerSize',10); %red x point // second distraction
                i = i+1;
            end
            if x(trial)
                plot(p(2,1), p(2,2),'or', 'MarkerSize',10); %red o point // target is here 
                plot(p(4,1), p(4,2), 'xb', 'MarkerSize',10); 


            end
            hold off;
            tic;
            pause;
            h725 = get(h, 'CurrentCharacter');
            elapsedTime = toc;


            if strcmp(h725,'y') & x(trial) | strcmp(h725,'n') & ~x(trial)
                correct = correct + 1; 
                RT_conj = [RT_conj, elapsedTime];
                plotting_matrix_conj = [plotting_matrix_conj ; i elapsedTime];

            end

        trial = trial +1;
        end
    end
    
    uc1_conj = unique( plotting_matrix_conj(:,1) ) ;
    mc2_conj = accumarray( plotting_matrix_conj(:,1), plotting_matrix_conj(:,2), [], @mean ) ;
    newData_conj = [uc1_conj, mc2_conj(uc1)];
    
    figure;
    hold on;
    axis([4 16 0.4 2.5]);
    xlabel("Set size");
    ylabel("Reaction Time");
    plot(newData_feat(:,1),newData_feat(:,2))
    plot(newData_conj(:,1),newData_conj(:,2), "r")
    hold off;
end
