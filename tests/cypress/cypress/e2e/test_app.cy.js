describe('Testes de API https://sherlock-f4n3.onrender.com/check_app', () => {

  it('Deve verificar app inválido', () => {
    cy.request({
      method: 'POST',
      url: 'https://sherlock-f4n3.onrender.com/check_app',
      body: { app: "Sherlock" },
      failOnStatusCode: false
    }).then((response) => {
      expect(response.status).to.eq(200);
      const data = response.body;
      expect(data).to.have.property('score');
      expect(data).to.have.property('reason');
      expect(data).to.have.property('description');
      expect(data).to.have.property('play_store');
      expect(data).to.have.property('app_store');
      expect(data.score).to.be.at.least(70);
    });
  });

  it('Deve verificar app válido de IA', () => {
    cy.request({
      method: 'POST',
      url: 'https://sherlock-f4n3.onrender.com/check_app',
      body: { app: "ChatGPT" },
      failOnStatusCode: false
    }).then((response) => {
      expect(response.status).to.eq(200);
      const data = response.body;
      expect(data).to.have.property('score');
      expect(data).to.have.property('reason');
      expect(data).to.have.property('description');
      expect(data).to.have.property('play_store');
      expect(data).to.have.property('app_store');
      expect(data.score).to.be.at.most(20);
    });
  });

  it('Deve verificar app válido de jogo', () => {
    cy.request({
      method: 'POST',
      url: 'https://sherlock-f4n3.onrender.com/check_app',
      body: { app: "brawl stars" },
      failOnStatusCode: false
    }).then((response) => {
      expect(response.status).to.eq(200);
      const data = response.body;
      expect(data).to.have.property('score');
      expect(data).to.have.property('reason');
      expect(data).to.have.property('description');
      expect(data).to.have.property('play_store');
      expect(data).to.have.property('app_store');
      expect(data.score).to.be.at.most(20);
    });
  });

});
