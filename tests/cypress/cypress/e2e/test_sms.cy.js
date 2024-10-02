describe('Testes de API - https://sherlock-f4n3.onrender.com/check_sms', () => {

    it('Deve verificar SMS de golpe 1', () => {
        cy.request({
            method: 'POST',
            url: 'https://sherlock-f4n3.onrender.com/check_sms',
            body: { sms: "Parabéns! Você ganhou um prêmio. Clique aqui para receber." },
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

    it('Deve verificar SMS de golpe 2', () => {
        cy.request({
            method: 'POST',
            url: 'https://sherlock-f4n3.onrender.com/check_sms',
            body: { sms: "Para resgatar o prêmio, insira seu CPF" },
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

    it('Deve verificar SMS sem golpe 1', () => {
        cy.request({
            method: 'POST',
            url: 'https://sherlock-f4n3.onrender.com/check_sms',
            body: { sms: "Oi mãe. Passo ai jantar mais tarde." },
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

    it('Deve verificar SMS sem golpe 2', () => {
        cy.request({
            method: 'POST',
            url: 'https://sherlock-f4n3.onrender.com/check_sms',
            body: { sms: "Bom dia! Como você está?" },
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

    it('Deve verificar SMS de golpe em inglês 1', () => {
        cy.request({
            method: 'POST',
            url: 'https://sherlock-f4n3.onrender.com/check_sms',
            body: { sms: "Congratulations! You have won a prize. Click here to claim it." },
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

    it('Deve verificar SMS sem golpe em inglês 1', () => {
        cy.request({
            method: 'POST',
            url: 'https://sherlock-f4n3.onrender.com/check_sms',
            body: { sms: "Hi mon. I'll come over for dinner later." },
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

    it('Deve verificar caso de SMS vazio', () => {
        cy.request({
            method: 'POST',
            url: 'https://sherlock-f4n3.onrender.com/check_sms',
            body: { sms: "" },
            failOnStatusCode: false
        }).then((response) => {
            // Verifica se o status da resposta é 200
            expect(response.status).to.eq(200);
            const data = response.body;
            // Verifica se as propriedades esperadas estão presentes
            expect(data).to.have.property('score');
            expect(data).to.have.property('reason');
            // Verifica se o score é >= 20
            expect(data.score).to.be.at.least(20);
        });
    });

});
