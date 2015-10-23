function fOut = curry(fh)
    fOut = fh;
    switch nargin(fOut)
      case 5
        fOut = @(bind)(curry(@(free1, free2, free3, free4) (fh(bind, free1, free2, free3, free4))));
      case 4
        fOut = @(bind)(curry(@(free1, free2, free3) (fh(bind, free1, free2, free3))));
      case 3
        fOut = @(bind)(curry(@(free1, free2) (fh(bind, free1, free2))));
      case 2
        fOut = @(bind)(curry(@(free1) (fh(bind, free1))));
      otherwise
        % Do nothing, 
end    
return