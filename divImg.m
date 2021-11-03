function divOutput = divImg(ui, uj)

ui_pre = padarray(ui, 1, 'replicate', 'pre'); ui_pre(end,:) = [];
ui_pre(1,:) = 0; ui(end,:) = 0;
ui_diff = ui - ui_pre;

uj_pre = padarray(uj',1, 'replicate', 'pre'); uj_pre = uj_pre'; uj_pre(:,end) = [];
uj_pre(:,1) = 0; uj(:,end) = 0;
uj_diff = uj - uj_pre;

divOutput = ui_diff + uj_diff;

end