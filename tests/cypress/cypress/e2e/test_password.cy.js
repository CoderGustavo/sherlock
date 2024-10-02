describe("Testes de API - https://sherlock-f4n3.onrender.com/check_password", () => {
    it('Deve verificar o nível da senha "senha"', () => {
        cy.request({
            method: "POST",
            url: "https://sherlock-f4n3.onrender.com/check_password",
            body: { password: "senha" },
            failOnStatusCode: false,
        }).then((response) => {
            // Verifica se o status da resposta é 200
            expect(response.status).to.eq(200);
            const data = response.body;
            // Verifica se as propriedades esperadas estão presentes
            expect(data).to.have.property("level");
            expect(data).to.have.property("description");
            // Verifica se o level é 2
            expect(data.level).to.eq(2);
        });
    });

    it('Deve verificar o nível da senha "minhasenha"', () => {
        cy.request({
            method: "POST",
            url: "https://sherlock-f4n3.onrender.com/check_password",
            body: { password: "minhasenha" },
            failOnStatusCode: false,
        }).then((response) => {
            // Verifica se o status da resposta é 200
            expect(response.status).to.eq(200);
            const data = response.body;
            // Verifica se as propriedades esperadas estão presentes
            expect(data).to.have.property("level");
            expect(data).to.have.property("description");
            // Verifica se o level é 4
            expect(data.level).to.eq(4);
        });
    });

    it('Deve verificar o nível da senha "minhasenha123"', () => {
        cy.request({
            method: "POST",
            url: "https://sherlock-f4n3.onrender.com/check_password",
            body: { password: "minhasenha123" },
            failOnStatusCode: false,
        }).then((response) => {
            // Verifica se o status da resposta é 200
            expect(response.status).to.eq(200);
            const data = response.body;
            // Verifica se as propriedades esperadas estão presentes
            expect(data).to.have.property("level");
            expect(data).to.have.property("description");
            // Verifica se o level é 6
            expect(data.level).to.eq(6);
        });
    });

    it('Deve verificar o nível da senha "Minhasenha123"', () => {
        cy.request({
            method: "POST",
            url: "https://sherlock-f4n3.onrender.com/check_password",
            body: { password: "Minhasenha123" },
            failOnStatusCode: false,
        }).then((response) => {
            // Verifica se o status da resposta é 200
            expect(response.status).to.eq(200);
            const data = response.body;
            // Verifica se as propriedades esperadas estão presentes
            expect(data).to.have.property("level");
            expect(data).to.have.property("description");
            // Verifica se o level é 8
            expect(data.level).to.eq(8);
        });
    });

    it('Deve verificar o nível da senha "Minhasenha123@"', () => {
        cy.request({
            method: "POST",
            url: "https://sherlock-f4n3.onrender.com/check_password",
            body: { password: "Minhasenha123@" },
            failOnStatusCode: false,
        }).then((response) => {
            // Verifica se o status da resposta é 200
            expect(response.status).to.eq(200);
            const data = response.body;
            // Verifica se as propriedades esperadas estão presentes
            expect(data).to.have.property("level");
            expect(data).to.have.property("description");
            // Verifica se o level é 10
            expect(data.level).to.eq(10);
        });
    });
});
