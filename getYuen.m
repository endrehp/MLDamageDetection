function yuen = getYuen(u,v,w1,w2)

    % returns the Yuen vector of two sets of mode shape and natural
    % frequency pairs
    
    % u and v are the undamaged and damaged mode shape vectors
    % w1 and w2 is the undamaged and damaged natural frequency
   
    yuen = u/w1 - v/w2;
    
end