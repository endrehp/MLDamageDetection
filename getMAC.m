function MAC = getMAC(u,v)
    % Modal assurance criterion MAC
    % Compare mode shapes vectors from damaged and undamaged beam
    
    MAC = abs(u'*v)^2/((u'*u)*(v'*v));

end


