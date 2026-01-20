function out = PSO(problem,params)
    %% Problem Definition

    CostFunction = problem.CostFunction; % Cost Function
    
    nVar = problem.nVar;            % Number of unknown/decision variables
    
    VarSize = [1 nVar];             % Matrix size of decision variables
    
    VarMin = problem.VarMin;        % Lower Bound of Decision variables
    VarMax = problem.VarMax;        % Upper Bound of Decision variables
    
    %% Parameters of PSO
    
    MaxIt = params.MaxIt;       % Maximum Number of Iterations
    
    nPop = params.nPop;         % Population Size (Swarm Size)
    
    w = params.w;               % Inertia Coefficient
    wdamp = params.wdamp;       % Damping Ratio of Inertia Coefficient
    c1 = params.c1;             % Personal Acceleration Coefficient
    c2 = params.c2;             % Social Acceleration Coefficient

    ShowIterInfo = params.ShowIterInfo; % Flag for showing iteration info

    MaxVelocity = 0.2*(VarMax-VarMin);
    MinVelocity = -MaxVelocity;
    
    %% Initialisation
    
    % Particle Template
    empty_particle.Position = [];
    empty_particle.Velocity = [];
    empty_particle.Cost = [];
    empty_particle.Best.Position = [];
    empty_particle.Best.Cost = [];
    
    % Create Population Array
    particle = repmat(empty_particle, nPop, 1);
    
    % Initialize Global Best
    GlobalBest.Cost = inf;
    GlobalBest.Position = [];

    % keep all results
    results = repmat(empty_particle,MaxIt+1,nPop);
    
    % Initialise Population members
    parfor i = 1:nPop
    
        pos = zeros(1,nVar);
        % Generate Random Solution
        for j = 1:nVar
             pos(j) = unifrnd(VarMin(j), VarMax(j));
        end

        particle(i).Position = pos;
    
        % Initialise Velocity
        particle(i).Velocity = zeros(VarSize);
    
        % Evaluation
        particle(i).Cost = CostFunction(particle(i).Position);
    
        % Update Personal Best
        particle(i).Best.Position = particle(i).Position;
        particle(i).Best.Cost = particle(i).Cost;

        results(1,i) = particle(i);
    
    end

    for i = 1:nPop
         % Update Global Best
        if particle(i).Best.Cost < GlobalBest.Cost

            GlobalBest = particle(i).Best;

        end
    end
    
    % Array for Best Cost on each interation
    BestCosts = zeros(MaxIt, 1);
    
    %% Main Loop of PSO
    
    for it = 1:MaxIt

        temp = repmat(empty_particle,nPop,1);
    
        parfor i = 1:nPop
    
            % Calculate Velocity
            particle(i).Velocity = w*particle(i).Velocity ...
                + c1*rand(VarSize).*(particle(i).Best.Position - particle(i).Position) ...
                + c2*rand(VarSize).*(GlobalBest.Position - particle(i).Position);

            particle(i).Velocity = max(particle(i).Velocity,MinVelocity);
            particle(i).Velocity = min(particle(i).Velocity,MaxVelocity);
            
    
            % Calculate Position
            particle(i).Position = particle(i).Position + particle(i).Velocity;

            % Apply Lower and Upper Bound Limits
            particle(i).Position = max(particle(i).Position,VarMin);
            particle(i).Position = min(particle(i).Position,VarMax);
    
            % Calculate Cost
            particle(i).Cost = CostFunction(particle(i).Position);

            % disp(['Cost: ' num2str(particle(i).Cost)]);
    
            % Compare to Personal Best
            if particle(i).Cost < particle(i).Best.Cost
    
                particle(i).Best.Position = particle(i).Position;
                particle(i).Best.Cost = particle(i).Cost;
    
            end

            temp(i) = particle(i);
    
        end

        results(it+1,:) = temp;

        for i = 1:nPop
             % Update Global Best
            if particle(i).Best.Cost < GlobalBest.Cost
    
                GlobalBest = particle(i).Best;
    
            end
        end
    
        % Store Best Cost Value
        BestCosts(it) = GlobalBest.Cost;
    
        % Display Interation Information
    
        if ShowIterInfo
            disp(['Iteration ' num2str(it) ': Best Cost =  ' num2str(BestCosts(it))])
        end

        % Damping Inertia Coefficient
    
        w = w*wdamp;
    
    end

    out.pop = particle;
    out.BestSol = GlobalBest;
    out.BestCosts = BestCosts;
    out.runningVal = results;

end