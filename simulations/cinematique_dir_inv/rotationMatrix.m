function R = rotationMatrix(phi, theta, sigma)
   cp = cos(phi);
   sp = sin(phi);
   ct = cos(theta);
   st = sin(theta);
   cs = cos(sigma);
   ss = sin(sigma);
   
   csmp = cos(sigma-phi)
   ssmp = sin(sigma-phi)
   
   R = [cp*ct*csmp-sp*ssmp -cp*ct*ssmp-sp*csmp cp*st;
       sp*ct*csmp+cp*ssmp -sp*ct*ssmp+cp*csmp sp*st;
       -st*csmp st*ssmp ct];
end

