function [ ret ] = wrap_handles(f)
%WRAP_HANDLES Returns a function that will call the passed function with
%the latest data from handles.
%   more detail?

    ret = @helper; 
    curried = curry(f); 
    nargin_f = nargin(f);
    
    function ret_ = helper(handles, varargin)
        
        if(length(varargin) > (nargin_f - 1) || length(varargin) + 1 < nargin_f)
            error('Function expected %i arguments but was given %i', (nargin_f), length(varargin) + 1);
        end
                      
        if(handles.count > 1) 

            data = handles.data{handles.count - 1};     
            unwrap = curried(data);
            
            for i = 1:(nargin_f - 1)
               unwrap = unwrap(varargin{i}); 
            end
            
            ret_ = unwrap();
        end
    end
end

