<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.scm.model.StockDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Stock Detail</title>
    <style>
        table {
            width: 50%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>Stock Detail</h2>
    <% 
        StockDTO stock = (StockDTO) request.getAttribute("stock");
        if (stock != null) {
    %>
    <table>
        <tr><th>Company Code</th><td><%= stock.getCOMPANY_CODE() %></td></tr>
        <tr><th>Date</th><td><%= stock.getDATE() %></td></tr>
        <tr><th>Open</th><td><%= stock.getOPEN() %></td></tr>
        <tr><th>High</th><td><%= stock.getHIGH() %></td></tr>
        <tr><th>Low</th><td><%= stock.getLOW() %></td></tr>
        <tr><th>Close</th><td><%= stock.getCLOSE() %></td></tr>
        <tr><th>Volume</th><td><%= stock.getVolume() %></td></tr>
    </table>
    <p><a href="javascript:history.back()">Back</a></p>
    <% } else { %>
    <p>No stock data found for the selected date.</p>
    <p><a href="javascript:history.back()">Back</a></p>
    <% } %>
</body>
</html>
