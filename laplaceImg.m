function laplaceOutput = laplaceImg(f)

[ui_pre,uj_pre] = gradImg(f, 'pre');
[ui_post,uj_post] = gradImg(f, 'post');

laplaceOutput = (ui_post-ui_pre) + (uj_post-uj_pre);

end