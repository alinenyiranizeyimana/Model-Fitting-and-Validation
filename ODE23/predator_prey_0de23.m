
function dn = predator_prey_0de23(~,n)

    Nh = n(1);  
    Np = n(2);  
    
    dNh = 0.1*Nh - 0.005*Nh*Np;
    dNp = -0.02*Np + 0.001*Nh*Np;
    
    dn = [dNh; dNp];

end

