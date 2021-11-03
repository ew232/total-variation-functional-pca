function [ui,uj] = gradImg(f, direction)

if strcmp(direction, 'pre')
    padr = padarray(f, 1, 'replicate', 'pre'); padr(end,:) = [];
    padc = padarray(f',1, 'replicate', 'pre'); padc = padc'; padc(:,end) = [];
    ui = f-padr;
    uj = f-padc;
elseif strcmp(direction, 'post')
    padr = padarray(f, 1, 'replicate', 'post'); padr(1,:) = [];
    padc = padarray(f',1, 'replicate', 'post'); padc = padc'; padc(:,1) = [];
    ui = padr-f;
    uj = padc-f;
end

end