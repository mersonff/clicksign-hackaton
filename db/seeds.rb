# Database seeds

def attach_flag(team, flag)
  team.flag.attach(
    io: Rails.root.join("spec/fixtures/files/#{flag}.svg").open,
    filename: "#{flag}.svg",
    content_type: 'image/svg+xml'
  )
end

# Creates users
User.create(name: 'John Doe', email: 'john@clicksign.com', password: 'foobar123', token_issued_at: Time.current)

# Create Stages

Stage.create(name: 'Fase de Grupos (Rodada 1)')
Stage.create(name: 'Fase de Grupos (Rodada 2)')
Stage.create(name: 'Fase de Grupos (Rodada 3)')
Stage.create(name: 'Oitavas de final')
Stage.create(name: 'Quartas de final')
Stage.create(name: 'Semi-finais')
Stage.create(name: 'Final')

# Create Teams

# Group A
qa = Team.create(name: 'Catar')
attach_flag(qa, 'qa')
ec = Team.create(name: 'Equador')
attach_flag(ec, 'ec')
sn = Team.create(name: 'Senegal')
attach_flag(sn, 'sn')
nl = Team.create(name: 'Holanda')
attach_flag(nl, 'nl')

# Group B
gb = Team.create(name: 'Inglaterra')
attach_flag(gb, 'gb')
ir = Team.create(name: 'Irã')
attach_flag(ir, 'ir')
us = Team.create(name: 'Estados Unidos')
attach_flag(us, 'us')
gb_wls = Team.create(name: 'Gales')
attach_flag(gb_wls, 'gb-wls')

# Group C
ar = Team.create(name: 'Argentina')
attach_flag(ar, 'ar')
sa = Team.create(name: 'Arábia Saudita')
attach_flag(sa, 'sa')
mx = Team.create(name: 'México')
attach_flag(mx, 'mx')
pl = Team.create(name: 'Polônia')
attach_flag(pl, 'pl')

# Group D
fr = Team.create(name: 'França')
attach_flag(fr, 'fr')
au = Team.create(name: 'Austrália')
attach_flag(au, 'au')
dk = Team.create(name: 'Dinamarca')
attach_flag(dk, 'dk')
tn = Team.create(name: 'Tunísia')
attach_flag(tn, 'tn')

# Group E
es = Team.create(name: 'Espanha')
attach_flag(es, 'es')
cr = Team.create(name: 'Costa Rica')
attach_flag(cr, 'cr')
de = Team.create(name: 'Alemanha')
attach_flag(de, 'de')
jp = Team.create(name: 'Japão')
attach_flag(jp, 'jp')

# Group F
be = Team.create(name: 'Bélgica')
attach_flag(be, 'be')
ca = Team.create(name: 'Canadá')
attach_flag(ca, 'ca')
mk = Team.create(name: 'Marrocos')
attach_flag(mk, 'mk')
hr = Team.create(name: 'Croácia')
attach_flag(hr, 'hr')

# Group G
br = Team.create(name: 'Brasil')
attach_flag(br, 'br')
rs = Team.create(name: 'Sérvia')
attach_flag(rs, 'rs')
ch = Team.create(name: 'Suíça')
attach_flag(ch, 'ch')
cm = Team.create(name: 'Camarões')
attach_flag(cm, 'cm')

# Group H
pt = Team.create(name: 'Portugal')
attach_flag(pt, 'pt')
gh = Team.create(name: 'Gana')
attach_flag(gh, 'gh')
uy = Team.create(name: 'Uruguai')
attach_flag(uy, 'uy')
kr = Team.create(name: 'Coreia do Sul')
attach_flag(kr, 'kr')
