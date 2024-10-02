describe('Testes de API - https://sherlock-f4n3.onrender.com/check_url', () => {

    it('Deve verificar URL encurtada', () => {
        cy.request({
            method: 'POST',
            url: 'https://sherlock-f4n3.onrender.com/check_url',
            body: { url: "http://tinyurl.com/blbw83" },
            failOnStatusCode: false
        }).then((response) => {
            // Verifica se o status da resposta é 200
            expect(response.status).to.eq(200);
            const data = response.body;
            // Verifica se as propriedades esperadas estão presentes
            expect(data).to.have.property('score');
            expect(data).to.have.property('reason');
            // Verifica se o score é >= 70
            expect(data.score).to.be.at.least(70);
        });
    });

    it('Deve verificar URL válida', () => {
        cy.request({
            method: 'POST',
            url: 'https://sherlock-f4n3.onrender.com/check_url',
            body: { url: "http://google.com.br" },
            failOnStatusCode: false
        }).then((response) => {
            // Verifica se o status da resposta é 200
            expect(response.status).to.eq(200);
            const data = response.body;
            // Verifica se as propriedades esperadas estão presentes
            expect(data).to.have.property('score');
            expect(data).to.have.property('reason');
            // Verifica se o score é <= 20
            expect(data.score).to.be.at.most(20);
        });
    });
});
