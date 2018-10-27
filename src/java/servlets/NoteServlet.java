/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import businesslogic.NoteService;
import domainmodel.Note;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author 759388
 */
public class NoteServlet extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        NoteService ns = new NoteService();        
        String action = request.getParameter("action");
        
        if (action != null) {
            switch (action) {
                case "view": {
                    int selectedNote = Integer.parseInt(request.getParameter("note"));
                    try {
                        Note note = ns.get(selectedNote);
                        request.setAttribute("selectedNote", note);
                    } catch (Exception ex) {
                        Logger.getLogger(NoteServlet.class.getName()).log(Level.SEVERE, null, ex);
                        request.setAttribute("errorMessage", "Unable to locate note.");
                    }
                    
                    break;
                }
                
                case "delete": {
                    int selectedNote = Integer.parseInt(request.getParameter("note"));
                
                    try {
                        if (ns.delete(selectedNote) == 0)
                            throw new Exception();
                    } catch (Exception ex) {
                        request.setAttribute("errorMessage", "Unable to delete note.");
                    }
                }
            }
        }
        
        request.setAttribute("currentDate", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        
        ArrayList<Note> notes = null;        
        try {
            notes = (ArrayList<Note>) ns.getAll();
        } catch (Exception ex) {
            Logger.getLogger(NoteServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("notes", notes);
        getServletContext().getRequestDispatcher("/WEB-INF/notes.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        Date dateCreated;
        String contents = request.getParameter("contents");

        NoteService ns = new NoteService();

        try {
            dateCreated = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dateCreated"));
            
            switch (action) {
                case "add": {
                    if (ns.insert(dateCreated, contents) == 0)
                        request.setAttribute("errorMessage", "Unable to insert note.");
                    
                    break;
                }
                
                case "edit": {
                    int noteId = Integer.parseInt(request.getParameter("noteId"));
                    
                    if (ns.update(noteId, dateCreated, contents) == 0)
                        request.setAttribute("errorMessage", "Unable to update note.");
                    
                    break;
                }
            }
        } catch (Exception ex) {
            request.setAttribute("errorMessage", "Whoops.  Could not perform that action.");
        }
        
        request.setAttribute("currentDate", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        
        ArrayList<Note> notes = null;
        
        try {
            notes = (ArrayList<Note>) ns.getAll();
        } catch (Exception ex) {
            Logger.getLogger(NoteServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        request.setAttribute("notes", notes);
        getServletContext().getRequestDispatcher("/WEB-INF/notes.jsp").forward(request, response);
    }
    

    
}
